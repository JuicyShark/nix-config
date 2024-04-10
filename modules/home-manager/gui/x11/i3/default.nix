{ config, lib, pkgs, ... }:
let
	mod = "Mod1";
in {
	xsession.windowManager.i3 = {
		enable = true;
		config = {
			modifier = mod;
			fonts = ["${config.font}"];

			keybindings = lib.mkOptionDefault {
				
				"${mod}+space" = "exec dmenu_run";
				"${mod}+b" = "exec firefox";
				"${mod}+Return" = "exec kitty";

				"${mod}+h" = "focus left";
				"${mod}+j" = "focus down";
				"${mod}+k" = "focus up";
				"${mod}+l" = "focus right";
				
				"${mod}+s" = "focus left";
				"${mod}+d" = "focus down";
				"${mod}+e" = "focus up";
				"${mod}+f" = "focus right";

				"${mod}+Left" = "focus left";
				"${mod}+Down" = "focus down";
				"${mod}+Up" = "focus up";
				"${mod}+Right" = "focus right";

				"${mod}+Shift+h" = "move left";
				"${mod}+Shift+j" = "move down";
				"${mod}+Shift+k" = "move up";
				"${mod}+Shift+l" = "move right";
				
				"${mod}+Shift+s" = "move left";
				"${mod}+Shift+d" = "move down";
				"${mod}+Shift+e" = "move up";
				"${mod}+Shift+f" = "move right";

				"${mod}+Shift+Left" = "move left";
				"${mod}+Shift+Down" = "move down";
				"${mod}+Shift+Up" = "move up";
				"${mod}+Shift+Right" = "move right";
				
				"${mod}+Control+h" = "split horizontal";
				"${mod}+Control+j" = "split vertical";
				"${mod}+Control+k" = "split vertical";
				"${mod}+Control+l" = "split horizontal";
				
				"${mod}+Control+s" = "split horizontal";
				"${mod}+Control+d" = "split vertical";
				"${mod}+Control+e" = "split vertical";
				"${mod}+Control+f" = "split horizontal";

				"${mod}+Control+Left" = "split horizontal";
				"${mod}+Control+Down" = "split vertical";
				"${mod}+Control+Up" = "split vertical";
				"${mod}+Control+Right" = "split horizontal";

				"${mod}+Shift+g" = "layout toggle tabbed split";

			};
		};
	};
}
