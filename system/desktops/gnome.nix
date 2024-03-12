{ pkgs, ...}:

{

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      gnome.enable = true;
    };
    displayManager= {
      autoLogin.enable = true;
      autoLogin.user = "cmde";
      defaultSession = "gnome";
      gdm.enable = true;
    };
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    gnome.gnome-terminal
    gnomeExtensions.appindicator
    gnomeExtensions.forge
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.tiling-assistant
    gnomeExtensions.caffeine
    gnomeExtensions.arcmenu
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  
  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
  gnome-console
]) ++ (with pkgs.gnome; [
  cheese # webcam tool
  gnome-music
  epiphany # web browser
  geary # email reader
  evince # document viewer
  gnome-characters
  totem # video player
  tali # poker game
  iagno # go game
  hitori # sudoku game
  atomix # puzzle game
]);
  nixpkgs.overlays = [
  (final: prev: {
    gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
      mutter = gnomePrev.mutter.overrideAttrs ( old: {
        src = pkgs.fetchgit {
          url = "https://gitlab.gnome.org/vanvugt/mutter.git";
          # GNOME 45: triple-buffering-v4-45
          rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
          sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
        };
      } );
    });
  })
];
}
