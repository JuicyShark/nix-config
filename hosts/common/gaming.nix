{ lib, pkgs, config, ... }:

{


  environment.systemPackages = with pkgs; [
    heroic
  ];

  # Enable Steam and gamescope
  ## Include latest GE proton
  programs = {
    steam = {
      enable = true;
      extest.enable = false;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
      remotePlay.openFirewall = true;

      # TODO Define primary monitor per host or known as headless
      gamescopeSession = {
        enable = false;
        args = [
         # "--output-width ${toString config.hardware.display.monitors[0].width}"
         # "--output-height 1440"
          "--prefer-output DP-1"
          "--steam"
          "--nested-refresh"
        ];
      };

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  hardware.xpadneo.enable = true;  # Xbox one Controller Support

}
