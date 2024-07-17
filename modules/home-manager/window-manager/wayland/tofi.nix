{ config, ...}:
let
  colour = config.colorScheme.palette;
in
{
  programs.tofi = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font";
      font-size = 25;
      text-color = "${colour.base05}";
      prompt-color = "${colour.base0E}";
      selection-color = "${colour.base0D}";
      background-color = "${colour.base02}";
      outline-color = "${colour.base0D}";
      border-color = "${colour.base0D}";

      width = "100%";
      height = "100%";
      output = "DP-1";
      outline-width = 6;
      padding-top = "15%";
      padding-bottom = "25%";
      padding-left = "38%";
      padding-right = "38%";

      terminal = "foot";

      hide-cursor = true;
      matching-algorithm = "normal";
      auto-accept-single = true;

    };
  };
}
