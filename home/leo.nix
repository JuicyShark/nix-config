{ pkgs, inputs, ... }:
{
  # Import files specific to Juicy User Config
  imports = [
    ./common     # Import Globals
    ./common/theme.nix
   	./programs
    ./window-manager/wayland/hyprland
  ];
# Daemon to manage secret (private) keys independently from any protocol
programs.gpg.enable = true;
services.gpg-agent = {
  enable = true;
  enableSshSupport = true;
  enableZshIntegration = true;
  pinentryPackage = pkgs.pinentry-gtk2;
  #pinentryFlavor = "gtk2"; # Hyprland/Wayland
};
  # Packages Specific to Juicy User
  home.packages = with pkgs; [
    bambu-studio
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    inputs.nix-gaming.packages.${pkgs.system}.rocket-league
    inputs.nix-gaming.packages.${pkgs.system}.technic-launcher
  ];

}
