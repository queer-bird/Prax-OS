{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [./languages.nix
             ./binds.nix
            ];

  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default.overrideAttrs (old: {
      makeWrapperArgs = with pkgs;
        old.makeWrapperArgs
        or []
        ++ [
          "--suffix"
          "PATH"
          ":"
          (lib.makeBinPath [
            clang-tools
            marksman
            nil
            nodePackages.bash-language-server
            nodePackages.vscode-css-languageserver-bin
            nodePackages.vscode-langservers-extracted
            shellcheck
          ])
        ];
    });

    settings = {
      editor = {
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        lsp.display-inlay-hints = true;
        statusline.center = ["position-percentage"];
        true-color = true;
        whitespace.characters = {
          newline = "↴";
          tab = "⇥";
        };
      };
    };
  };
}
