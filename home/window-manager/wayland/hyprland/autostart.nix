{ ... }:
{
		wayland.windowManager.hyprland.settings = {
			exec-once = [
        "hyprpaper"
		    "hypridle"
		    "ags"

        "[workspace 1 silent] qutebrowser"
			  "[workspace 1 silent] kitty nvim -c 'Neorg index'"
			  "[workspace 2 silent] kitty emacs -nw "
        "[workspace 3 silent] signal-desktop"
        "[workspace 3 silent] discord"
        "[workspace 5 silent] steam"
        "[workspace 5 silent] tidal-hifi"
        "[workspace 5 silent] kitty cava"
		  ];
		};
}
