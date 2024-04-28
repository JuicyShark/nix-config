{ lib, config, pkgs, ... }:
{
  imports = [
    ./games
  ];
  config = lib.mkIf (config.gaming.enable) {
    environment.systemPackages = with pkgs; [

    ];
  };
}
