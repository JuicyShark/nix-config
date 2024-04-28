{ lib, config, pkgs, ... }:
{
  imports = [
    ./games
    ./openvpn.nix
  ];
  config = lib.mkIf (config.gaming.enable) {
    environment.systemPackages = with pkgs; [

    ];
  };
}
