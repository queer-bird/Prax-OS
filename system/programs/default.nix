{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    # ./qt.nix
    ./steam.nix
    ./xdg.nix
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;
  };
}
