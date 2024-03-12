{ pkgs, ... }:

{
  programs.helix = {
    settings = {
      keys = {
        normal = {
          n = "move_char_left";
          e = "move_line_down";
          i = "move_line_up";
          o = "move_char_right";

          l = "insert_mode";
          L = "insert_at_line_start";

          j = "open_below";
          J = "open_above";

          m = "search_next";
          M = "search_prev";

          y = "yank_to_clipboard";
          Y = "yank_to_clipboard";
          P = "paste_clipboard_before";
          p = "paste_clipboard_after";
        };
        normal.g = {
          n = "goto_line_start";
          o = "goto_line_end";
          h = "goto_next_buffer";
        };
        normal.C-w = {
          n = "jump_view_left";
          e = "jump_view_down";
          i = "jump_view_up";
          o = "jump_view_right";

          N = "swap_view_left";
          E = "swap_view_down";
          I = "swap_view_up";
          O = "swap_view_right";
          };
        normal.h = {
          h = "match_brackets";
          s = "surround_add";
          r = "surround_replace";
          d = "surround_delete";
          a = "select_textobject_around";
          i = "select_textobject_inner";
        };
      };  
    };    
  };
}
