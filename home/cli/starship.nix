{ config, ... }:

{
	programs.starship = {
    enable = true;
    enableNushellIntegration = true;

		settings = {
      time = {
        disabled = true;
      };
      battery = {
        disabled = true;
      };
    /*  prompt = {
        palette = "catppuccin-mocha";
        palettes = {
          catppuccin-mocha = {
            red = "${config.colorScheme.palette.base08}";
            green = "${config.colorScheme.palette.base0B}";
            yellow = "${config.colorScheme.palette.base0A}";
            blue = "${config.colorScheme.palette.base0D}";
            pink = "${config.colorScheme.palette.base0F}";
            teal = "${config.colorScheme.palette.base0C}";
          };
        };
      }; */
		};
	};
}
