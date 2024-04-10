{ pkgs, ... }:
{  
	nixpkgs.config.allowUnfree = true;
	home.packages = with pkgs; [
		
		/* Polkit */
		polkit_gnome
		
		wireplumber
		#pwvucontrol
		mpv
		obsidian
			
		/* Notifications */
		libnotify
		
		/* Miscellaneous */
		xorg.xinit	
		logiops
		wl-clipboard
		wl-mirror
		wlr-randr
	  	nix-search-cli 
		signal-desktop
		tidal-hifi
		(pkgs.nerdfonts.override { fonts = [ "Hack" ]; }) # Font		
  ];
}
