{ lib, osConfig, ... }:
{
  	config = lib.mkIf osConfig.desktop.enable {
		wayland.windowManager.hyprland.settings = {
			exec-once = [
      "hyprpaper"
		  "hypridle"
		  "waybar"
		  "polkit-gnome-authentication-agent-1"

      "[workspace 1 silent; group new] qutebrowser"
			"[workspace 1 silent] kitty nvim -c 'Neorg index'"
			"[workspace 2 silent] kitty nvim"
      "[workspace 3 silent; float] signal-desktop"
      "[workspace 3 silent; float] discord"
      "[workspace 5 silent] steam"
      "[workspace 5 silent] tidal-hifi"
      "[workspace 5 silent] kitty cava"
		  ];
		};
  };
}
