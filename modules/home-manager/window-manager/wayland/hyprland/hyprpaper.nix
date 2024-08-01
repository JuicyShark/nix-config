{
  config,
  pkgs,
  lib,
  ...
}: let
  changeWallpaperScript = ''
    #!/usr/bin/env bash

    WALLPAPER_DIR="${config.xdg.userDirs.pictures}/wallpapers"

    # Load all wallpapers
    for wallpaper in "$WALLPAPER_DIR"/*; do
        hyprpaper preload "$wallpaper"
    done

    # Select a random wallpaper
    RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    # Set the random wallpaper
    hyprpaper set "$RANDOM_WALLPAPER"

    # Unload all but the current wallpaper
    for wallpaper in "$WALLPAPER_DIR"/*; do
        if [ "$wallpaper" != "$RANDOM_WALLPAPER" ]; then
            hyprpaper unload "$wallpaper"
        fi
    done
  '';
in {
  /*
     home.file.".local/bin/change_wallpaper.sh".text = changeWallpaperScript;

  systemd.user.services.change-wallpaper = {
    Unit = {
      Description = "Change wallpaper to a random one from wallpapers folder";
      WantedBy = ["default.target"];
      #ConditionUser = "hyprland";
    };
    Service = {
      ExecStart = "${pkgs.bash}/bin/bash $HOME/.local/bin/change_wallpaper.sh";
      Restart = "on-failure";
      #Environment = "DISPLAY=:0";
    };
  };

  systemd.user.timers.change-wallpaper-timer = {
    Unit = {
      Description = "Timer to change wallpaper every 31 hours";
      WantedBy = ["timers.target"];
    };
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "31h";
      Persistent = true;
    };
  };

  # Ensure the script is executable
  home.activation.ensureExecutable = lib.mkAfter ''
    chmod +x ${config.home.homeDirectory}/.local/bin/change_wallpaper.sh
  '';
  */

