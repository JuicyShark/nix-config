{ lib, osConfig, ... }:
{
  config = lib.mkIf osConfig.desktop.enable {
    wayland.windowManager.hyprland.settings = {
  		workspace = [
  			"1, monitor:DP-1, default:true, defaultName:󰖟"
  			"2, monitor:DP-1, defaultName:󰊴, decorate:false, layoutopt:orientation:left"
  			"3, monitor:DP-1, defaultName:󰍥, gapsin:10, gapsout:20"
  			"4, monitor:DP-1, defaultName:, border:4, on-created-empty:kitty"
  			"5, monitor:DP-1, defaultName:"
  			"6, monitor:DP-1, defaultName:, on-created-empty:tidal-hifi, gapsin:30, gapsout:75"
  			"7, monitor:HDMI-A-1, default:true, name:"
  		];

      windowrule = [
        "suppressevent maximize, class:^(.*)$"
        "idleinhibit always, class:^(steam_app.*)$"
        "idleinhibit focus, title:^(.*WATCH ON BINGE —.*)$"
        "idleinhibit focus, title:^(.*- YouTube.*)$"
        "idleinhibit focus, title:^(Netflix -.*)$"
        "idleinhibit focus, title:^(Prime Video.*)$"
        "idleinhibit focus, title:^(.*- Twitch.*)$"
        "idleinhibit always, title:^(Picture-in-Picture)$"
  		  "opacity 0.95, class:^(kitty)$"
  		  "opacity 0.85, class:^(steam)$"
  		  "opacity 0.90, class:^(Signal)$"
  		  "opacity 0.92 override 0.92 override 1.0 override, class:^(firefox)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(.*WATCH ON BINGE.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(.*- YouTube.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(Netflix -.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(Prime Video.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(.*- Twitch.*)$"
        "opacity 1.0 override 1.0 override 1.0 override, title:^(Picture-in-Picture)$"

        "noborder, class:^(steam_app.*)$"
        "noblur, class:^(steam_app.*)$"
        "xray 1, class:^(steam_app.*)$"

        "suppressevent fullscreen, title:^(steam_app.*)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "suppressevent fullscreen, title:^(Picture-in-Picture)$"
        "float, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden —.*)$"
        "size 550 750, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden —.*)$"
        ];
    };
  };
}
