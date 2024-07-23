{
  lib,
  pkgs,
  config,
  ...
}: {
  options.gamingPC.enable = lib.mkEnableOption "Enable Steam";

  config = lib.mkIf (config.gamingPC.enable) {
    environment.systemPackages = with pkgs; [
      heroic
    ];

    # Enable Steam, Include latest GE proton
    programs = {
      steam = {
        enable = true;
        extest.enable = false;
        localNetworkGameTransfers.openFirewall = true;
        dedicatedServer.openFirewall = true;
        remotePlay.openFirewall = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };

    hardware.xpadneo.enable = true; # Xbox one Controller Support
  };
}
