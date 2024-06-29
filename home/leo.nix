{ pkgs, ... }:
{
  # Import files specific to Juicy User Config
  imports = [
    ./common     # Import Globals
   	./programs        
    ./development
    ./window-manager/wayland/hyprland
  ];

  # Packages Specific to Juicy User
  home.packages = with pkgs; [
    osu-lazer
    bambu-studio
  ];

}
