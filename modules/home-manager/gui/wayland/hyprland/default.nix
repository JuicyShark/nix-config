{ config, lib, inputs, pkgs, ... }: 

{ 
	imports = [
		inputs.hyprland.homeManagerModules.default
		./hyprland.nix
		./waybar
		./anyrun.nix
		./mako.nix
	];
	home.packages = with pkgs; [
		hypridle
		hyprlock
		hyprpaper
		hyprpicker
		hyprlang
		hyprcursor
		hyprland-protocols
		ydotool
	];
	wayland.windowManager.hyprland = {
		enable = true;
		systemd = {
			variables = ["--all"];
			extraCommands = [
				"systemctl --user stop graphical-session.target"
				"systemctl --user start hyprland-session.target"
      			];
    		};
	};	
}

