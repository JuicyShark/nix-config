{ lib, osConfig, ... }:
{
  config = lib.mkIf osConfig.desktop.enable {
    wayland.windowManager.hyprland.settings = {
  		workspace = [
  			"1, monitor:DP-1, default:true, defaultName:󰖟"
  			"2, monitor:DP-1, defaultName:"
  			"3, monitor:DP-1, defaultName:󰍥"
  			"4, monitor:DP-1, defaultName:󰊴, border:false, decorate:false, shadow:false"
  			"5, monitor:DP-1, defaultName:, gapsin:30, gapsout:75"
  			"7, monitor:HDMI-A-1, default:true, name:"
  		];

      windowrulev2 = [
        "suppressevent maximize, class:^(.*)$"
        # Stop PC Sleeping during media
        "idleinhibit always, class:^(steam_app.*)$"
        "idleinhibit focus, title:^(.*WATCH ON BINGE —.*)$"
        "idleinhibit focus, title:^(.*- YouTube.*)$"
        "idleinhibit focus, title:^(Netflix -.*)$"
        "idleinhibit focus, title:^(Prime Video.*)$"
        "idleinhibit focus, title:^(.*- Twitch.*)$"
        "idleinhibit always, title:^(Picture-in-Picture)$"

        # Opacity themeing, disable for streaming
  		  "opacity 0.95, class:^(kitty)$"
  		  "opacity 0.85, class:^(steam)$"
        "opacity 0.90, class:^(Signal)$"
        "opacity 0.90, class:^(discord)$"
        "opacity 0.90, class:^(tidal-hifi)$"
        "opacity 0.92 override 0.92 override 1.0 override, class:^(firefox)$"
        #"opacity 0.92 override 0.92 override 1.0 override, class:^(org.qutebrowser.qutebrowser)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(.*WATCH ON BINGE.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(.*- YouTube.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(Netflix -.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(Prime Video.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(.*- Twitch.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(Picture-in-Picture)$"

       # Game Specific Settings
        "workspace 4, class:^(steam_app.*)$"
        "noblur, class:^(steam_app.*)$"
        "xray 1, class:^(steam_app.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, class:^(steam_app.*)$"

        "float, class:^(Waydroid)$"

        # Misc Web apps
        "workspace 3, class:^(discord)$"
        "workspace 3, class:^(Signal)$"
        "workspace 5, class:^(tidal-hifi)$"


        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "noborder, title:^(Picture-in-Picture)$"
        "size 1280 720, title:^(Picture-in-Picture)$"
        "move onscreen 100%-w-50, title:^(Picture-in-Picture)$"
        "keepaspectratio, title:^(Picture-in-Picture)$"
        "suppressevent fullscreen, title:^(Picture-in-Picture)$"


        "float, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden —.*)$"
        "size 550 750, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden —.*)$"
        "float, onworkspace:r[3-4]"
        ];
    };
  };
}
