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

  home-manager.users.juicy = import ../../modules/home-manager/window-manager/x11/i3;
     services = {
			xserver = {
  			enable = true;
				displayManager.lightdm.enable = true;
				windowManager.i3.enable = true;
  		};
		};
  networking.hostName = "dante";
}
