{ lib, config, pkgs, ... }:
{
  imports = [
    ./games
    ./openvpn.nix
    ./cyber-security.nix
  ];
  config = lib.mkIf (config.gaming.enable) {
    environment.systemPackages = with pkgs; [

    ];
  };
}
