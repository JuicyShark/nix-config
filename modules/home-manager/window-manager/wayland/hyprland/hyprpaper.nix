{ config, ... }:
{
  services.hyprpaper = {
    enable = true;

    settings = {
	    preload = "${config.xdg.userDirs.pictures}/wallpapers/arcade-background.png";
      wallpaper = [
        "DP-1,${config.xdg.userDirs.pictures}/wallpapers/arcade-background.png"
        "HDMI-A-1,${config.xdg.userDirs.documents}/wallpapers/arcade-background.png"
      ];
	    splash = true;
    };
  };
}
