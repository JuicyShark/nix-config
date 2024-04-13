# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
	imports = [
		../shared-configuration.nix
		./hardware-configuration.nix
	];
	
	# Enable Custom flags for Module selection
	homelab.enable = true;
	desktop.enable = true;
	hardware.nvidia.enable = true;
	hardware.nvidia.legacyEnable = true;

  home-manager.users.juicy = import ../../modules/home-manager/gui/x11/i3;
 
  networking.hostName = "dante";
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
}
