{pkgs, ... }:

{

  imports = [
    ./firefox.nix
    ./obs.nix
    ./themes.nix
    ./mpv.nix
  ];
	
	home.packages = with pkgs; [
			
		obsidian
		/* Miscellaneous */
    xfce.thunar
    xorg.xinit	
		logiops
	 	nix-search-cli 
		signal-desktop
		tidal-hifi
	];
}
