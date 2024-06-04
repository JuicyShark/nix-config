{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    libsixel # display images inline
  ]; 
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        app-id = "terminal";
        title = "terminal";
        locked-title = "no";
        term = "xterm-256color";
        pad = "0x0 center";
        shell = "zsh";

        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        selection-target = "clipboard";

        dpi-aware = false;
        font = "Hack Nerd Font:size 16";
        font-bold = "Hack Nerd Font:size 17";
      };
      scrollback = {
        lines = 10000;
        multiplier = 3;
      };

      tweak = {
        font-monospace-warn = "no"; # reduces startup time
        sixel = "yes";
      };

      cursor = {
        style = "beam";
        beam-thickness = 2;
      };

      mouse = {
        hide-when-typing = "yes";
      };

      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
        protocols = "http, https, ftp, ftps, file";
        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };
      colors = {
        foreground = "${config.colorScheme.palette.base05}"; # Text
        background = "${config.colorScheme.palette.base00}"; # Base
        regular0 = "${config.colorScheme.palette.base03}"; # Surface 1
        regular1 = "${config.colorScheme.palette.base08}"; # red
        regular2 = "${config.colorScheme.palette.base0B}"; # green
        regular3 = "${config.colorScheme.palette.base0A}"; # yellow
        regular4 = "${config.colorScheme.palette.base0D}"; # blue
        regular5 = "${config.colorScheme.palette.base0F}"; # pink
        regular6 = "${config.colorScheme.palette.base0C}"; # teal
        regular7 = "${config.colorScheme.palette.base06}"; # Subtext 0
        bright0 = "${config.colorScheme.palette.base04}"; # Surface 2
        bright1 = "${config.colorScheme.palette.base08}"; # red
        bright2 = "${config.colorScheme.palette.base0B}"; # green
        bright3 = "${config.colorScheme.palette.base0A}"; # yellow
        bright4 = "${config.colorScheme.palette.base0D}"; # blue
        bright5 = "${config.colorScheme.palette.base0F}"; # pink
        bright6 = "${config.colorScheme.palette.base0C}"; # teal
        bright7 = "${config.colorScheme.palette.base07}"; # Subtext 0
      };
    };
  };
}
