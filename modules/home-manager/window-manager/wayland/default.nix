{ pkgs, osConfig, ... }:

{
	imports =  [
		./hyprland
		./waybar
		./mako.nix
		./anyrun.nix
	];
	
		xdg.mimeApps.enable = true;
		home = {
			sessionVariables = {
    				MOZ_ENABLE_WAYLAND = 1;
  			};
		};
		
}
