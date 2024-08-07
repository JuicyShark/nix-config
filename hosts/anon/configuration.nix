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

  desktop.enable = true;
  cybersecurity.enable = true;

	networking.hostName = "anon";
}
