# your system.  Help is available in the configuration.nix(4) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

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
  programs = {
    steam = {
      enable = true;
      extest.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession = {
        enable = true;
        args = [
          "--output-width 3440"
          "--output-height 1440"
          "--framerate-limit 120"
          "--prefer-output DP-1"
          "--adaptive-sync"
          "--expose-wayland"
          "--steam"
        ];
      };
    };

    gamescope.enable = true;
  };
}
