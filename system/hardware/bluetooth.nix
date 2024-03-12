{ ... }: {
  hardware.bluetooth = {
    enable = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/114222
  systemd.user.services.telephony_client.enable = false;
}
