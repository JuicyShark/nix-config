# your system.  Help is available in the configuration.nix(4) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

{
	hardware.nvidia.enable = true;
	desktop.enable = true;
	gaming.enable = true;
	
	imports = [
	  ../shared-configuration.nix
		./hardware-configuration.nix
	];
	
  home-manager.users.juicy = import ../../modules/home-manager/window-manager/wayland;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [

    ];
    loader = {
	systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
    };
  };

	services.greetd = {
		enable = true;
    package = pkgs.greetd.greetd;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
        user = "juicy";
      };
    };
  };

  networking.hostName = "juicy";

  # Probably better place to put these
  hardware = {
    bluetooth.enable = true;
    logitech.wireless.enable = true;
  };

  networking = {
    defaultGateway = "192.168.54.99";
    nameservers = [ "8.8.8.8" "8.8.4.4" "192.168.54.99"];
    interfaces = {
      "enp5s0" = {
        useDHCP = false;
          ipv4 = { 
            addresses = [
              {
                address = "192.168.54.54";
                prefixLength = 24;
              }
            ];
          };
        };
      };
  };
}
