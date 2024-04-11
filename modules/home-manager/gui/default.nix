{ config, lib, ... }:

{
	imports = [
		./wayland
		./x11
		./firefox.nix
		./themes.nix
	];

	#++ lib.optional (config.desktopEnvironment == "x11") ./x11
	#++ lib.optional (config.desktopEnvironment == "wayland") ./wayland;
	
	home.packages = with pkgs; [
		mpv
		#obsidian
			
		/* Notifications */
		libnotify
		
		/* Miscellaneous */
		xorg.xinit	
		logiops
	  	nix-search-cli 
		signal-desktop
		tidal-hifi
	];
}
