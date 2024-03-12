{ config, pkgs, ... }:
let
  visualizer_name = "my_fifo";
  visualizer_fifo = "/tmp/mpd.fifo";
  mpd = {
    host = "127.0.0.1";
    port = 6600;
    musicDir = "${config.home.homeDirectory}/Music";
    playlistDir = "${config.home.homeDirectory}/.config/mpd/playlist";
  };
in
{
  home.packages = with pkgs; [ mpc_cli playerctl picard ];

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };

    settings = {
      
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      playlist_editor_display_mode = "classic";

      media_library_primary_tag = "album_artist";
      media_library_albums_split_by_date = "no";
      startup_screen = "media_library";
      ignore_leading_the = "yes";
      display_volume_level = "no";
      external_editor = "nano";
      use_console_editor = "yes";
      mouse_support = "yes";

      visualizer_data_source = visualizer_fifo;
      visualizer_output_name = visualizer_name;
      visualizer_type = "spectrum";
      visualizer_in_stereo = "yes";
      visualizer_look = "●●";
      visualizer_color = "white, cyan, blue, magenta, red, red, black";
      visualizer_spectrum_smooth_look = "yes";
      visualizer_autoscale = "yes";
      visualizer_spectrum_dft_size = 3;
    };

    bindings = with builtins; let
      toBinding = s: let get = elemAt s; in { key = get 0; command = get 1; };
    in
    map toBinding [
      [ "n" [ "previous_column" "master_screen" "jump_to_parent_directory" ] ]
      [ "o" [ "next_column" "slave_screen" "enter_directory" ] ]
      [ "i" "scroll_up" ]
      [ "e" "scroll_down" ]
      [ "g" "page_up" ]
      [ "G" "page_down" ]
      [ "d" "delete_playlist_items" ]
      [ "k" "next_found_item" ]
      [ "K" "previous_found_item" ]
      [ "P" "show_playlist_editor" ]
      [ "B" "show_browser" ]
      [ "s" "show_search_engine" ]
      [ "S" "show_search_engine" ]
      [ "8" "show_visualizer" ]
      [ "ctrl-s" "save_playlist" ]
      [ "c" "clear_main_playlist" ]
      [ "ctrl-l" "show_lyrics" ]
    ];
  };

  services.mpd = {
    enable = true;
    musicDirectory = mpd.musicDir;
    playlistDirectory = mpd.playlistDir;
    network = {
      listenAddress = mpd.host;
      port = mpd.port;
    };
    extraConfig = ''
      user "cmde"
      group "users"
      restore_paused "yes"
      auto_update	"yes"
      auto_update_depth "5"
      follow_outside_symlinks "yes"
      follow_inside_symlinks "yes"

      audio_output {
        type "pipewire"
        name "My PipeWire Device"
      }

      audio_output {
        type "fifo"
        name "${visualizer_name}"
        path "${visualizer_fifo}"
        format "44100:16:2"
      }

      filesystem_charset		"UTF-8"
    '';
  };

  services.mpdris2 = {
    enable = true;
    notifications = false;
    multimediaKeys = false;
    mpd = {
      host = mpd.host;
      port = mpd.port;
      musicDirectory = mpd.musicDir;
    };
  };
}
