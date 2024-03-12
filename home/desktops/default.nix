{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    isoImage.squashfsCompression = "gzip -Xcompression-level 1";

    "cmde@gnome" = [
      ../.
      ./gnome
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  # we need to pass this to NixOS' HM module
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {


      "cmde_gnome" = homeManagerConfiguration {
        modules = homeImports."cmde@gnome";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
