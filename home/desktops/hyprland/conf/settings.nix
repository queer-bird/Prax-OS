{config, ...}:

 {
  wayland.windowManager.hyprland.settings = {
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "WLR_DRM_NO_ATOMIC,1"
      "WLR_NO_HARDWARE_CURSORS,1"
      "_JAVA_AWT_WM_NONREPARENTING,1"
      "XCURSOR_SIZE,48"
      "WLR_RENDERER,vulkan"
      "__GL_GSYNC_ALLOWED,0"
      "__GL_VRR_ALLOWED,0"      
    ];

    exec-once = [
      "swaybg -m fill -i ${config.var.wallpaper}"
      "waybar"
      "mako"
    ];

monitor = [                                                                                                   
           "eDP-1, preferred, auto, 1.000000" 
          ];     

    general = {
      layout = "master";
      border_size = 3;
      gaps_in = 0;
      gaps_out = 0;
      allow_tearing = true;
      resize_on_border = true;
    };

master = {
      mfact = 0.55;
      new_is_master = false;
      new_on_top = false;
};

    decoration = {
      rounding = 0;
      blur = {
        enabled = false;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;

        passes = 3;
        size = 10;
      };

      drop_shadow = false;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
    };

    animations = {
      enabled = false;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };


    input = {
      follow_mouse = 1;
      sensitivity = 0.4;
      accel_profile = "flat";
      touchpad.scroll_factor = 0.1;
    };

    misc = {
      # disable dragging animation
      animate_mouse_windowdragging = false;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;

      # we do, in fact, want direct scanout
      no_direct_scanout = false;
    };

    # touchpad gestures
    gestures = {
      workspace_swipe = false;
      workspace_swipe_forever = false;
    };

    xwayland.force_zero_scaling = false;

    debug.disable_logs = true;
};
}
