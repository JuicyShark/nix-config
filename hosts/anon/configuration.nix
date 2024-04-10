# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{pkgs,  ... }:

{
	imports = [
		../../configuration.nix
		./hardware-configuration.nix
	];

	  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

	# Enable Custom flags for Module selection
	homelab.enable = false;
	desktop.enable = true;
	gaming.enable = false;
	virtual.enable = true;


	networking.hostName = "juno";
	nix = {
    		settings = {
      			warn-dirty = false;
      			auto-optimise-store = true;
     			substituters = ["https://nix-gaming.cachix.org"];
      		};
  	};
 	
	system.stateVersion = "24.05"; 

}
