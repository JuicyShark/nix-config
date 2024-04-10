# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{lib, ... }:

{
	imports = [
		../../configuration.nix
		./hardware-configuration.nix
	];
	
	# Enable Custom flags for Module selection
	homelab.enable = true;
	desktop.enable = true;
	
	hardware.nvidia.enable = true;
	hardware.nvidia.legacyEnable = true;



	networking.hostName = "dante";
	nix = {
    		settings = {
      			warn-dirty = false;
      			auto-optimise-store = true;
     			substituters = ["https://nix-gaming.cachix.org"];
      		};
  	};
	services.xserver.enable = true;
	services.xserver.windowManager.leftwm.enable = true;
	
 	
	system.stateVersion = "24.05"; 

}
