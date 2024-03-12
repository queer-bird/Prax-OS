{ pkgs, ...}:

{

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  services.cinnamon.apps.enable = true;

}
