{
  pkgs,
  ...
}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
          clock = true;
      indicator = true;
    };
  };
}
