{
  lib,
  self,
  inputs,
  ...
}: {
  imports = [
    inputs.matugen.nixosModules.default
    inputs.nix-index-db.hmModules.nix-index
    inputs.hyprlock.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    self.nixosModules.theme

    # editors
    ./editors/helix
    ./editors/neovim
    ./editors/vscode

    # programs
    ./programs
    ./programs/games
    #../../programs/wayland
    ./desktops/plasma

    # media services
    ./services/media/playerctl.nix

    # system services
    # ../../services/system/dunst.nix
    # ../../services/system/kdeconnect.nix
    # ../../services/system/polkit-agent.nix
    ./services/system/power-monitor.nix
    ./services/system/udiskie.nix

    # wayland-specific
    #  ../../services/wayland/hyprpaper.nix
    # ../../services/wayland/hypridle.nix

    # terminal emulators
    ./terminal/emulators/foot.nix
    ./specialisations.nix
    ./terminal
  ];

  home = {
    username = "cmde";
    homeDirectory = "/home/cmde";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      lib = prev.lib // {colors = import "${self}/lib/colors" lib;};
    })
  ];
}
