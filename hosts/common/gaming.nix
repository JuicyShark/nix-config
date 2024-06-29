{ pkgs, config, ... }:
let 
 isJuicy = config.main-user == "juicy"; 
in
  {

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

     /* gamescopeSession = {
        enable = true;
        args = [

          "--output-width 2560"
          "--output-height 1440"
          "--prefer-output DP-1"
          "--steam"
          "--nested-refresh"
        ];
      }; */

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  hardware.xpadneo.enable = true;  # Xbox one Controller Support
}
