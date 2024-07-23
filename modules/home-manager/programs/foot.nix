{
  config,
  pkgs,
  ...
}: let
  colour = config.colorScheme.palette;
in {
  home.packages = with pkgs; [
    libsixel # display images inline
  ];
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "foot.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "foot.desktop";
    };
  };
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        app-id = "terminal";
        title = "terminal";
        locked-title = "no";
        term = "foot-direct";
        pad = "2x0";
        shell = "zsh";

        resize-delay-ms = 25;

        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        selection-target = "both";

        dpi-aware = false;
        font = "JetBrainsMono Nerd Font:size=14";
        font-bold = "JetBrainsMono Nerd Font:size=15";
        bold-text-in-bright = "yes";

        box-drawings-uses-font-glyphs = "no";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
      };

      scrollback = {
        lines = 10000;
        multiplier = "3.5";
      };

      tweak = {
        font-monospace-warn = "no"; # reduces startup time
        #allow-overflowing-double-width-glyphs = true;
        sixel = "yes";
      };

      cursor = {
        style = "block";
        unfocused-style = "hollow";
        color = "${colour.base00} ${colour.base0D}";
        beam-thickness = 2;
      };

      mouse = {
        hide-when-typing = "no";
      };

      url = {
        launch = "xdg-open \${url}";
        label-letters = "arstgneioqwfpluycdhz";
        osc8-underline = "url-mode";
        protocols = "http, https, ftp, ftps, file, git, irc, ircs, news, sftp, ssh";
        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };
      colors = {
        alpha = "0.69"; # Nice
        foreground = "${colour.base05}"; # Text
        background = "${colour.base00}"; # Base
        regular0 = "${colour.base03}"; # Surface 1
        regular1 = "${config.colorScheme.palette.base08}"; # red
        regular2 = "${config.colorScheme.palette.base0B}"; # green
        regular3 = "${config.colorScheme.palette.base0A}"; # yellow
        regular4 = "${config.colorScheme.palette.base0D}"; # blue
        regular5 = "${config.colorScheme.palette.base06}"; # pink
        regular6 = "${config.colorScheme.palette.base0C}"; # teal
        regular7 = "${config.colorScheme.palette.base0D}"; # Subtext 0
        bright0 = "${config.colorScheme.palette.base04}"; # Surface 2
        bright1 = "${config.colorScheme.palette.base09}"; # red
        bright2 = "${config.colorScheme.palette.base0B}"; # green
        bright3 = "${config.colorScheme.palette.base0F}"; # yellow
        bright4 = "${config.colorScheme.palette.base07}"; # blue
        bright5 = "${config.colorScheme.palette.base0E}"; # pink
        bright6 = "${config.colorScheme.palette.base0C}"; # teal
        bright7 = "${config.colorScheme.palette.base0B}"; # Subtext 0

        selection-foreground = "${colour.base05}";
        selection-background = "414356";
        search-box-no-match = "11111b ${colour.base08}";
        search-box-match = "${colour.base05} ${colour.base02}";
        jump-labels = "11111b ${colour.base09}";
      };
    };
  };
}
