{ config, pkgs, callPackage, ... }: 

{
	environment.pathsToLink = [ "/libexec" ];

	services.xserver = {
		enable = true;

		desktopManager.xterm.enable = false;
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				i3status
				i3lock
				dmenu
				kitty
			];
		};
	};
}
