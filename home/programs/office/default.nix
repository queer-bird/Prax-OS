{pkgs, ...}: {

  home.packages = with pkgs; [
    libreoffice
    xournalpp
  ];
}
