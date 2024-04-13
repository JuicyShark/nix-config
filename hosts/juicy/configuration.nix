# your system.  Help is available in the configuration.nix(4) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
	hardware.nvidia.enable = true;
	desktop.enable = true;
	gaming.enable = true;
	
	imports = [
	  ../shared-configuration.nix
		./hardware-configuration.nix
	];
	
  programs.displayManager.wayland.enable = true;
  #home-manager.users.juicy.wayland.windowManager.hyprland.settings.monitor = [ "DP-1,5120x1440@120,0x0,1" "HDMI-A-1,disable" ]; 
  home-manager.users.juicy = import ../../modules/home-manager/gui/wayland/hyprland;
  programs.hyprland.enable = true;

  networking.hostName = "juicy";
	
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;
}
