{pkgs, ...}: {
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvchad
      nvchad-ui
    ];

    extraPackages = with pkgs; [gcc ripgrep fd];

    extraConfig = let
      luaRequire = module:
        builtins.readFile (builtins.toString
          ./config
          + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "mappings"
      ]);
    in ''
      lua << 
      ${luaConfig}
      
    '';
  };
}
