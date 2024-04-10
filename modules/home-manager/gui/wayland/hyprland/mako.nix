{ config, ... }:
{
	services.mako = with config.colorScheme.palette; {
		enable = true;
		maxVisible = 3;
		font = "${config.font} 15";
    backgroundColor = "#${base00}";
  	borderColor = "#${base0E}";
  	borderRadius = 5;
  	borderSize = 3;
		textColor = "#${base05}";
		anchor = "top-center";
	  layer = "overlay";
		height = 350;
		width = 525;
		defaultTimeout = 7500;
		maxIconSize = 160;
  };
}
