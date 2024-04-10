{ config, lib, ... }:
let 
	displayConfig = import ../../display-manager.nix {inherit lib;};
	extraConfig = if config.displayManager == "wayland" then
			import ./wayland {inherit lib;}
		else if config.displayManager == "x11" then
			import ./x11 {inherit lib;}
		else {};
in
{
	imports = [
	./wayland
	./x11
	];
}
