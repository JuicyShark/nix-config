# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
	imports = [
		../shared-configuration.nix
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

  home-manager.users.juicy = import ../../modules/home-manager/gui/x11/i3;
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;

	networking.hostName = "anon";
}
