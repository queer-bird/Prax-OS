{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
#     howdy = inputs.nixpkgs-howdy;
    mod = "${self}/system";

    # get the basic config to build on top of
    inherit (import "${self}/system") desktop laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    io = nixosSystem {
      inherit specialArgs;
      modules =
        desktop
        ++ [
          ./PraxBox


          "${mod}/programs/gamemode.nix"
          "${mod}/desktops/plasma.nix"
          "${mod}/programs/steam.nix"

#         "${mod}/services/kmonad"
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

           inputs.hm.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              #users.cmde.imports = homeImports."cmde@io";
              users.cmde.imports = [../home/profiles/PraxBox];
              extraSpecialArgs = specialArgs;
            };
          }
          inputs.agenix.nixosModules.default
#           inputs.chaotic.nixosModules.default
        ];
    };

    # rog = nixosSystem {
    #   inherit specialArgs;
    #   modules =
    #     laptop
    #     ++ [
    #       ./rog
    #       "${mod}/core/lanzaboote.nix"

    #       "${mod}/programs/gamemode.nix"
    #       "${mod}/programs/hyprland.nix"
    #       "${mod}/programs/steam.nix"

    #       "${mod}/services/kmonad"
    #       {home-manager.users.cmde.imports = homeImports."cmde@rog";}
    #     ];
    # };

    # kiiro = nixosSystem {
    #   inherit specialArgs;
    #   modules =
    #     desktop
    #     ++ [
    #       ./kiiro
    #       {home-manager.users.cmde.imports = homeImports.server;}
    #     ];
    # };
  };
}
