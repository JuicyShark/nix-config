{ inputs, pkgs, osConfig, lib, ... }: 
{
	imports = [
		inputs.hyprland.homeManagerModules.default
		./hyprland.nix
	];

  config = lib.mkIf osConfig.desktop.enable { 
  	home.packages = with pkgs; [
		  hypridle
	  	hyprlock
	  	hyprpaper
	  	hyprpicker
	  	hyprlang
	  	hyprcursor
	  	hyprland-protocols
	];
    wayland.windowManager.hyprland = {
      enable = true;
      settings.monitor = [ ",highrr,0x0,1" "HDMI-A-1,disable" ]; 
      
      systemd = {
			  variables = ["--all"];
			  extraCommands = [
			  	"systemctl --user stop graphical-session.target"
			  	"systemctl --user start hyprland-session.target"
        ];
      };
    };
	};
}

