{config, ...}: let
  colour = config.stylix.base16Scheme;
in {
  programs = {
    man = {
      enable = true;
      generateCaches = true;
    };
    navi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        cheats = {
          paths = [
            "~/documents/cheatsheets"
          ];
        };
      };
    };
    tealdeer = {
      enable = true;
      settings = {
        display = {
          use_pager = true;
          compact = true;
        };
        style = {
          description = {
            foreground = "${colour.base0B}";
            background = "${colour.base00}";
            underline = false;
            bold = true;
            italic = false;
          };
          command_name = {
            foreground = "${colour.base0E}";
            background = "${colour.base00}";
            underline = false;
            bold = true;
            italic = false;
          };
          example_text = {
            foreground = "${colour.base05}";
            background = "${colour.base00}";
            underline = false;
            bold = false;
            italic = true;
          };
          example_code = {
            foreground = "${colour.base0D}";
            background = "${colour.base00}";
            underline = false;
            bold = false;
            italic = false;
          };
          example_variable = {
            foreground = "${colour.base0B}";
            background = "${colour.base00}";
            underline = true;
            bold = false;
            italic = false;
          };
        };
        updates = {
          auto_update = true;
          auto_update_interval_hours = 128;
        };
      };
    };
  };
  manual.manpages.enable = true;
}
