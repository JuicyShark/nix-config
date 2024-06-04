{ config, ... }:
{
	programs.kitty = {
		enable = true;
		settings = {
			confirm_os_window_close = 0;
			font_size = 13;
			background_opacity = "0.80";
			background = "#${config.colorScheme.palette.base00}";
			foreground = "#${config.colorScheme.palette.base05}";
			selection_background = "#${config.colorScheme.palette.base0D}";
			selection_foreground = "#${config.colorScheme.palette.base00}";
			url_color = "#${config.colorScheme.palette.base04}";
			cursor = "#${config.colorScheme.palette.base05}";
			color0 = "#${config.colorScheme.palette.base03}";
			color1 = "#${config.colorScheme.palette.base08}";
			color2 = "#${config.colorScheme.palette.base0B}";
			color3 = "#${config.colorScheme.palette.base0A}";
			color4 = "#${config.colorScheme.palette.base0D}";
			color5 = "#${config.colorScheme.palette.base0E}";
			color6 = "#${config.colorScheme.palette.base0C}";
			color7 = "#${config.colorScheme.palette.base05}";
			color8 = "#${config.colorScheme.palette.base04}";
			color9 = "#${config.colorScheme.palette.base08}";
			color10 = "#${config.colorScheme.palette.base0B}";
			color11 = "#${config.colorScheme.palette.base0A}";
			color12 = "#${config.colorScheme.palette.base0D}";
			color13 = "#${config.colorScheme.palette.base0E}";
			color14 = "#${config.colorScheme.palette.base0C}";
			color15 = "#${config.colorScheme.palette.base0B}";
		};
		font = {
			name = config.font;
		};
		shellIntegration.enableZshIntegration = true;
	};
}

