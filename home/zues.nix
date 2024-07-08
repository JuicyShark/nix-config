{ pkgs, inputs, ... }:
{
  # Import Files Specific to Homelab config
  imports = [
 	./common   # Global Home-Manager options
        ./window-manager/wayland/hyprland
      ];

  home.packages = with pkgs; [
    
  ];

}
