let
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";
  source =  "/etc/profiles/per-user/cmde/etc/profile.d/hm-session-vars.sh";
  # binds $MOD + [shift +] {1..10} to [move to] workspace {1..10}   
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$MOD, ${ws}, workspace, ${toString (x + 1)}"
        "$MOD SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);
in {
  wayland.windowManager.hyprland.settings = {
    # mouse movements
    bindm = [
      "$MOD, mouse:272, movewindow"
      "$MOD, mouse:273, resizewindow"
      "$MOD ALT, mouse:272, resizewindow"
    ];

    # binds
    bind = let
      monocle = "dwindle:no_gaps_when_only";
    in
      [
        # compositor commands
        "$MOD, C, killactive,"
        "$MOD, F, fullscreen,"
        "$MOD, D, exec, rofi -show drun"
        "$MOD SHIFT, F, togglefloating,"

        # utility
        # terminal
        "$MOD, T, exec, kitty"
        # logout menu
        "$MOD, Escape, exec, wlogout -p layer-shell"
        # lock screen
        "$MOD, L, exec, loginctl lock-session"

        # move focus
        "$MOD, $RIGHT, layoutmsg, cyclenext"
        "$MOD, $LEFT, layoutmsg, cycleprev"
        "$MOD SHIFT, $RIGHT, layoutmsg, swapenext"
        "$MOD SHIFT, $LEFT, layoutmsg, swapprev"
        "$MOD, $DOWN, splitratio, +0.05"
        "$MOD, $UP, splitratio, -0.05"

        # screenshot
        # stop animations while screenshotting; makes black border go away
        ", Print, exec, ${screenshotarea}"
        "$MOD SHIFT, R, exec, ${screenshotarea}"

        "CTRL, Print, exec, grimblast --notify --cursor copysave output"
        "$MOD SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output"

        "ALT, Print, exec, grimblast --notify --cursor copysave screen"
        "$MOD SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen"

      ]
      ++ workspaces;

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

      # backlight
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];
  };
}
