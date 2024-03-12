{ pkgs, ... }:

{

home.packages = with pkgs; [
  (vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      bbenoist.nix
      kamadorueda.alejandra
    ];
  })
];

}
