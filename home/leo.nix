{ pkgs, inputs, ... }:
{
  # Import files specific to Juicy User Config
  imports = [
    ./common     # Import Globals
   	./programs
    ./window-manager/wayland/hyprland
  ];

  # Packages Specific to Juicy User
  home.packages = with pkgs; [
    bambu-studio
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    inputs.nix-gaming.packages.${pkgs.system}.rocket-league
    inputs.nix-gaming.packages.${pkgs.system}.technic-launcher
  ];

}
