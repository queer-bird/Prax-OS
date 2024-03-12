{ pkgs, ...}:

{

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager= {
      gdm.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [

    cosmic-bg
    cosmic-osd
    cosmic-term
    cosmic-edit
    cosmic-comp
    cosmic-randr
    cosmic-panel
    cosmic-icons
    cosmic-files
    cosmic-session
    cosmic-greeter
    cosmic-applet
    cosmic-settings
    cosmic-launcher
    cosmic-protocol
    cosmic-screenshot
    cosmic-applibrary
    cosmic-design-demo
    cosmic-notifications
    cosmic-workspaces-epoch
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  
}
