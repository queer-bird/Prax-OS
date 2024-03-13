{pkgs, ...}: {
  imports = [
    ../../editors/helix

    ../../programs

    ../../services/media/mpd.nix

    ../../services/system/kdeconnect.nix
    ../../services/system/polkit-agent.nix
    ../../services/system/power-monitor.nix
    ../../services/system/udiskie.nix
  ];

  home.packages = with pkgs; [
    libsForQt5.kontact
  ];
}
