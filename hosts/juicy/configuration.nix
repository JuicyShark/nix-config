# your system.  Help is available in the configuration.nix(4) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{pkgs,  ... }:

{

	hardware.nvidia.enable = true;
	desktop.enable = true;
	gaming.enable = true;
	
	imports = [
		../../configuration.nix
		./hardware-configuration.nix
	];
	
	programs.displayManager.wayland.enable = true;
	home-manager.users.juicy.wayland.windowManager.hyprland.settings.monitor = [ "DP-1,5120x1440@120,0x0,1" "HDMI-A-1,disable" ]; 
	networking.hostName = "juicy";
	nix = {
    		settings = {
      			warn-dirty = false;
      			auto-optimise-store = true;
      			substituters = ["https://nix-gaming.cachix.org"];
      			trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    		};
  	};


	
	security.polkit.enable = true;
	services.xserver.excludePackages = [ pkgs.xterm ];
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;

	systemd = {
    		user.services.polkit-gnome-authentication-agent-1 = {
      		description = "polkit-gnome-authentication-agent-1";
      		wantedBy = ["graphical-session.target"];
      		wants = ["graphical-session.target"];
      		after = ["graphical-session.target"];
      		serviceConfig = {
        		Type = "simple";
        		ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        		Restart = "on-failure";
        		RestartSec = 1;
        		TimeoutStopSec = 10;
      			};
    		};
	};

	system.stateVersion = "24.05"; 

}
