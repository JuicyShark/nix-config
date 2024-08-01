{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  config = lib.mkIf (config.gui.gamingPC.enable) {
    environment.systemPackages = with pkgs; [
      heroic
      ryujinx
      moonlight-qt
      inputs.nix-gaming.packages.${pkgs.system}.osu-stable
      inputs.nix-gaming.packages.${pkgs.system}.rocket-league
      inputs.nix-gaming.packages.${pkgs.system}.technic-launcher
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
