{ config, ... }:
{
  services.hyprpaper = {
    enable = true;

    settings = {
	    preload = "${config.xdg.userDirs.documents}/nixos-config/home/window-manager/wayland/hyprland/backgrounds/arcade-background.png";
      wallpaper = [
        "DP-1,${config.xdg.userDirs.documents}/nixos-config/home/window-manager/wayland/hyprland/backgrounds/arcade-background.png"
        "HDMI-A-1,${config.xdg.userDirs.documents}/nixos-config/home/window-manager/wayland/hyprland/backgrounds/arcade-background.png"
      ];
	    splash = true;
    };
  };
}
