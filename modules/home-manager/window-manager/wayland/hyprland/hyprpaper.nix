{ lib, config, osConfig, pkgs, ... }:
{
  config = lib. mkIf osConfig.desktop.enable {
    home.packages = with pkgs; [
      hyprpaper
    ];
    
    xdg.configFile."hypr/hyprpaper.conf".text = ''
	    preload = ${config.home.homeDirectory}/nixos/modules/home-manager/window-manager/wayland/hyprland/backgrounds/arcade-background.png
	    wallpaper = DP-1,${config.home.homeDirectory}/nixos/modules/home-manager/window-manager/wayland/hyprland/backgrounds/arcade-background.png
	    splash = true
    '';
  };
}
