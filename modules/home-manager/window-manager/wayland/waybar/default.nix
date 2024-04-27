{ pkgs, config, ... }:

{
	programs.waybar = {
		enable = true;
		package = pkgs.waybar;
    		
		style = ''

			* {
      	font-family: ${config.font};
      	font-size: 24px;
			}
  
			window#waybar {
				background: #${config.colorScheme.palette.base01};
				color: #${config.colorScheme.palette.base05};
				opacity: 0.90;
			}

			tooltip {
  				background: #${config.colorScheme.palette.base00};
  				border-radius: 15px;
  				border-width: 2px;
  				border-style: solid;
  				border-color: #${config.colorScheme.palette.base0E};
  				font-size: 16px;
			}

			tooltip label {
  				padding: 7px;
			}

			#workspaces {
  				padding-top: 10px;
			}
			#workspaces button {
				color: #${config.colorScheme.palette.base05};
				padding-top: 5px;
				padding-bottom: 5px;
				padding-right: 8px;
				margin: 5px;
			}
			#workspaces button.empty {
				color: #${config.colorScheme.palette.base04};
			}
			#workspaces button.visible {
				color: #${config.colorScheme.palette.base0D};
			}
			#workspaces button.active {
				color: #${config.colorScheme.palette.base0B};
			}
			#workspaces button.urgent {
				color: #${config.colorScheme.palette.base0D};
			}
	
			#custom-launcher {
  				color: #${config.colorScheme.palette.base0D};
  				padding-top: 10px;
					padding-right: 5px;
			}

			#network {
				color: #${config.colorScheme.palette.base0D};
				padding-top: 15px; 
				padding-bottom: 15px;
				padding-right: 10px;
			}

			#network.disconnected {
				color: #${config.colorScheme.palette.base08};
			}

			#wireplumber {
				color: #${config.colorScheme.palette.base0B};
				padding-bottom: 5px;
			}
			#wireplumber.percent {
				font-size: 17px;
				padding-bottom: 15px;
			}
			
			#custom-calendar-icon {
				color: #${config.colorScheme.palette.base0D};
				padding-bottom: 5px;
				padding-right: 7px;
			}
			#custom-time-icon {
  				color: #${config.colorScheme.palette.base0E};
					padding-bottom: 5px;
					padding-right: 7px;
  		}

			#clock {
  				font-size: 19px;
  				color: #${config.colorScheme.palette.base0D};
			}

			#clock.date {
  				font-size: 19px;
  				color: #${config.colorScheme.palette.base0D};
			padding-bottom: 15px
			}	



			#clock.time {
					font-size: 19px;
  				color: #${config.colorScheme.palette.base0E};
					padding-bottom: 15px;
			}
			#custom-power {
				color: #${config.colorScheme.palette.base08};
  			padding-bottom: 15px;
				padding-right: 7px;
			}
		'';

		settings =  {
			mainBar = {
    		position = "left";
    		layer = "top";
    		width = 45;
    		margin-top = 0;
    		margin-bottom = 0;
				margin-left = 0;
    		margin-right = 0;
    		
				modules-left = [
  				"custom/launcher"
    			"hyprland/workspaces"
    		];
    		modules-center = [	
    			"custom/calendar-icon"
					"clock"
	      	"clock#date"
	      	"custom/time-icon"
					"clock#time"	
				];
				modules-right = [
					"tray"
					"network"
					"wireplumber"
					"wireplumber#percent"
					"group/group-power"
    		];
	
				"custom/calendar-icon" = {
    			format = "";
  				tooltip = false;
  			};
				clock = {
					format = "{:%a}";
					tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
				};
  			"clock#date" = {
					format = "{:%d}";
  				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
  			};
  			"custom/time-icon" = {
  				format = "";
					tooltip = false;
				};
				"clock#time" = {
					format = "{:%H\n%M}";
  			};
  		
				"hyprland/workspaces" = {
  				active-only = false;
      		all-outputs = false;
      		disable-scroll = true;
      		on-scroll-up = "hyprctl dispatch workspace e-1";
      		on-scroll-down = "hyprctl dispatch workspace e+1";
      		format = "{icon}";
      		on-click = "activate";
      		format-icons = {
						"1" = "󰖟";
						"2" = "󰊴";
						"3" = "󰍡";
						"4" = "";
						"5" = "󱀁";
						"6" = "󰂔";
        		sort-by-number = true;
      		};
    		};
     
				memory = {
    			format = "󰍛 {used}%";
  				format-alt = "󰍛 {used}/{total} GiB";
    			interval = 5;
    		};

    		cpu = {
    			format = "󰻠 {usage}%";
    			format-alt = "󰻠 {avg_frequency} GHz";
    			interval = 5;
    		};

    		network = {
    			format-wifi = "";
    			format-ethernet = "󰈀";
    			tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
    			format-disconnected = "󰖪";
    			on-click = "hyprctl dispatch exec kitty nmtui";
    		};
				
    		tray = {
    			icon-size = 22;
    			spacing = 5;
  			};

				wireplumber = {
					format = "{icon}";
					format-muted = "󰝟";
					format-icons = ["󰕿" "󰖀" "󰕾"];
					scroll-step = 1.5;
					max-volume = 125;
				};
				"wireplumber#percent" = {
					format = "{volume}%";
				};

				"custom/launcher" = {
					format = "";
					on-click= "hyprctl dispatch exec anyrun";
					tooltip = "false";
				};
				"group/group-power" = {
					"orientation" = "inherit";
					"drawer" =  {
						"transition-duration" = 500;
						"children-class" = "not-power";
						"transition-left-to-right" = false;
					};
				"modules" = [
    			"custom/power"
    			"custom/quit"
  				"custom/lock"
  				"custom/reboot"
					];
				};
					
				"custom/quit" = {
					"format" = "󰗼";
					"tooltip" = true;
					"on-click" = "hyprctl dispatch exit";
				};
				"custom/lock" = {
					"format" = "󰍁";
					"tooltip" = true;
					"on-click" = "hyprctl dispatch exec hyprlock";
				};
				"custom/reboot" = {
					"format" = "󰜉";
    			"tooltip" = true;
    			"on-click" = "reboot";
				};
				"custom/power" = {
    			"format" = "";
    			"tooltip" = true;
    			"on-click" = "shutdown now";
				};
  		};
		};	
	};
}
