{pkgs, ...}: {
  imports = [
    ./location.nix
    ./pipewire.nix
  ];

  services = {
    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };
}
