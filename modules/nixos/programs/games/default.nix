{ config, lib, ... }:
{
  imports = [
    ./steam.nix
  ];
  config = lib.mkIf (config.gaming.enable) {
    programs = {
      gamescope.enable = true;
      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {

        };
      };
    };
  };
}
