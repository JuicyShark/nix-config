{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    workspace =
      [
        "1, monitor:DP-1, default:true, gapsin:0, gapsout:0, rounding:false"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1, gapsin:0, gapsout:0, shadow:false, rounding:false"

        "m[HDMI-A-1], gapsout:0, gapsin:0, border:false, rounding:false, decorate:false, shadow:false"
        "6, monitor:HDMI-A-1, default:true"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "0, monitor:HDMI-A-1"
      ]
      ++ (
        if osConfig.hardware.keyboard.zsa.enable
        then [
          "w[vt1] m[DP-1] r[3-4], gapsout:13 1050 33 1050"
          "w[vt2] m[DP-1] r[3-4], gapsout:13 400 33 400"
          "w[vt1] m[DP-1] r[5-5], gapsout:0 830 0 830, gapsin:0"
        ]
        else []
      );

    windowrulev2 =
      [
        #Tagging windows
        "tag games, class:^(steam_app.*)$"
        "tag games, class:(Waydroid)"
        "tag games, class:(osu!)"

        "tag music, class:^(tidal-hifi)$"
        "tag music, title:^(ncmpcpp.*)$"

        "tag media, title:^(.*WATCH ON BINGE —.*)$"
        "tag media, title:^(.*- YouTube.*)$"
        "tag media, title:^(Netflix -.*)$"
        "tag media, title:^(Prime Video.*)$"
        "tag media, title:^(.*- Twitch.*)$"
        "tag media, title:^(Picture-in-Picture)$"
        "tag media, class:(mpv)"

        "tag pinnedMedia, title:(Picture-in-Picture)$"
        "tag pinnedMedia, class:(mpv)"

        "tag social, class:^(Signal)$"
        "tag social, class:^(discord)$"
        "tag social, title:^(https://www.facebook.com.*)$ class:^(org.qutebrowser.qutebrowser)$"

        "tag browser, class:(org.qutebrowser.qutebrowser)"
        "tag browser, class:(firefox)"

        #Misc tools
        "tag floatingTools, class:^(com.saivert.pwvucontrol)$"
        "tag floatingTools, class:^(RimPy)$"
        "tag floatingTools, title:^(Extension: (Bitwarden - Free Password Manager).*)$"

        "tag term, class:(kitty)"

        "idleinhibit always, tag:games"
        "idleinhibit always, tag:pinnedMedia"
        "idleinhibit focus, tag:media"
        "idleinhibit fullscreen, tag:media"

        "opacity 1.00 override 1.00 override 1.0 override, tag:games"
        "opacity 1.00 override 1.00 override 1.0 override, tag:media"

        # Match tags to certain workspaces
        "monitor DP-1, tag:games"
        "workspace 5, tag:games"
        "syncfullscreen 1, tag:games"
        "noborder 1, tag:games"
        "noblur 1, tag:games"
        "xray 1, tag:games"
        "noanim 1, tag:games"
        "group deny, tag:games"

        # Pinned Media (mainly videos doing PnP)
        # Disable decorations and bar
        # ensure pinned between workspaces
        "float, class:^(keymapp)$"
        "float, tag:pinnedMedia"
        "float, tag:floatingTools"
        "pin, tag:pinnedMedia"
        "noborder, tag:pinnedMedia"
        "plugin:hyprbars:nobar, tag:pinnedMedia"
        "maxsize 2000 1150, tag:pinnedMedia"
        "minsize 900 580, tag:PinnedMedia"
        "minsize 860 650, tag:floatingTools"

        #"move onscreen 100%-w-50, tag:PinnedMedia"
        #"keepaspectratio, tag:pinnedMedia"
        "suppressevent fullscreen, tag:pinnedMedia"

        "float, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden —.*)$"
        "size 550 750, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden —.*)$"
        "float,class:RimPy"
      ]
      ++ (
        if osConfig.hardware.keyboard.zsa.enable
        then [
          # Dont allow windows to maximize unless specified
          "suppressevent maximize, class:^(.*)$"
          # Flating windows should have a title bar
          "plugin:hyprbars:nobar, floating:0"
          "float, floating:0, onworkspace:2"
          "workspace 3, tag:social"
          "workspace 5, class:^(steam_app.*)$"
          "workspace 5, fullscreen:1"
          "workspace 6, tag:music"
        ]
        else []
      );
  };
}
