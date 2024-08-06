{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    rpi-imager
    bambu-studio
    keymapp
    bitwarden-desktop
    lan-mouse
  ];
  gui = {
    enable = true;
    cybersecurity.enable = false;
    gamingPC.enable = true;
  };

  hardware = {
    keyboard.zsa.enable = true;
    bluetooth.enable = true;
    logitech.wireless.enable = true;
  };
  networking.defaultGateway.interface = "enp5s0";
  networking.enableIPv6 = true;
  networking.useNetworkd = false;
  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp5s0";
    address = [
      "192.168.54.54/24"
    ];
    routes = [
      {Gateway = "192.168.54.99";}
    ];
    # make the routes on this interface a dependency for network-online.target
    #  linkConfig.RequiredForOnline = "routable";
  };
  imports = [
    ../../modules/nixos/nvidia.nix
    ../../users/juicy/juicy.nix
    ../shared-system-configuration.nix
    ./hardware-configuration.nix
  ];
}
