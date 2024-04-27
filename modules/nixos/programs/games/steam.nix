{ pkgs, config, lib, ... }:
{
  config = lib.mkIf (config.gaming.enable) {
    programs.steam = {
      enable = true;
      extest.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      gamescopeSession = {
        enable = true;
        args = [
          "--output-width 3440"
          "--output-height 1440"
          "--framerate-limit 120"
          "--prefer-output DP-1"
          "--expose-wayland"
          "--steam"
        ];
      };
    };
  };
}
