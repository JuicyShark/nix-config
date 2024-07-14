{ pkgs, inputs, ... }:

{
  imports = [
    ../../modules/nixos/nvidia.nix
    ../../users/juicy/juicy.nix
    ../shared-system-configuration.nix
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs.zig
    pkgs.wally-cli   # Flash zsa Keyboard
    pkgs.keymapviz   # Zsa Oryx dep
    pkgs.rpi-imager  # Raspberry Pi Imaging
    pkgs.bambu-studio
    pkgs.moonlight-qt
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    inputs.nix-gaming.packages.${pkgs.system}.rocket-league
    inputs.nix-gaming.packages.${pkgs.system}.technic-launcher
  ];

  cybersecurity.enable = false;
  gamingPC.enable = true;

  programs = {
    hyprland.enable = true;
  };

  hardware = {
    keyboard.zsa.enable = true;
    bluetooth.enable = true;
    #logitech.wireless.enable = true;
  };
}