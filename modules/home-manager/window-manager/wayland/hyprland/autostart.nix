{ lib, osConfig, ... }:
{
  config = lib.mkIf osConfig.desktop.enable {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
		    "hyprpaper"
			  "hypridle"
		    "waybar"
		    "polkit-gnome-authentication-agent-1"
			  "systemctl start --user logid.service"
			  "[workspace 1 silent] firefox"
			  "[workspace 1 silent] kitty"
			  "[workspace 2 silent] steam"
			  "[workspace 3 silent] signal-desktop"
		  ];
    };
  };
}
