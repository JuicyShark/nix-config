{pkgs, config, lib, ... }:

{

  imports = [
    ./firefox.nix
    ./themes.nix
  ];
 #  ++ lib.optional (config.environment.systemPackages.use_wayland_wm == "1") ./x11
  # ++ lib.optional (config.environment.systemPackages.use_x11_wm == "1") ./wayland;
	
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
