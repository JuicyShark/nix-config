{ config, ... }:
{
  services.hyprpaper = {
    enable = true;

    settings = {
	    preload = "${config.home.homeDirectory}/nixos/home/window-manager/wayland/hyprland/backgrounds/arcade-background.png";
	    wallpaper = "DP-1,${config.home.homeDirectory}/nixos/home/window-manager/wayland/hyprland/backgrounds/arcade-background.png";
	    splash = true;
    };
  };
}
