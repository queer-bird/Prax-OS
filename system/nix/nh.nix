{inputs, ...}: {
  imports = [
    inputs.nh.nixosModules.default
  ];

  # nh default flake
  environment.variables.FLAKE = "/home/cmde/Documents/Projects/Prax/Prax-OS";

  nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
