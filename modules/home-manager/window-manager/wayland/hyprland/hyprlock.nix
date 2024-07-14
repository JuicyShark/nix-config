{ config, ... }:
{
    services.hypridle = {
        enable = true;

        settings = {
	        general = {
            lock_cmd = "pidof hyprlock || hyprlock";      # avoid starting multiple hyprlock instances.
            before_sleep_cmd = "loginctl lock-session";   # lock before suspend.
            after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
          };



          listener = [
            {
	            timeout = 900;                                 # 15min
              on-timeout = "loginctl lock-session";          # lock screen when timeout has passed
	          }
            {
	            timeout = 1200;                                 # 20 min
    	        on-timeout = "hyprctl dispatch dpms off";       # screen off when timeout has passed
    	        on-resume = "hyprctl dispatch dpms on && hyprctl reload";         # screen on when activity is detected after timeout has fired.
            }
          ];
        };
      };

      programs.hyprlock = {
        enable = true;

        settings = {
          background = {
    	      monitor = "DP-1";
    	      path = "${config.home.homeDirectory}/documents/nixos-config/modules/home-manager/window-manager/wayland/hyprland/backgrounds/arcade-background.png";
            blur_passes = 2;
            contrast = 1;
            brightness = 0;
            vibrancy = 1;
            vibrancy_darkness = 0;
	        };

          general = {
	          no_fade_in = false;
    	      grace = 0;
    	      disable_loading_bar = false;
	        };

	    input-field = {
	    monitor = "DP-1";
    	size = "450, 75";
    	outline_thickness = 2;
    	dots_size = "0.2"; # Scale of input-field height, 0.2 - 0.8
    	dots_spacing = "0.2"; # Scale of dots' absolute size, 0.0 - 1.0
    	dots_center = true;
    	outer_color = "rgba(0, 0, 0, 0)";
    	inner_color = "rgba(30, 30, 46, 0.3)";
    	font_color = "rgb(200, 200, 200)";
    	fade_on_empty = false;
    	placeholder_text = "<i><span foreground='##ffffff99'>Welcome back</span></i>";
   	hide_input = false;
    position = "0, -120";
    halign = "center";
    valign = "center";
	  };

    label = [
    {
	  monitor = "DP-1";
    text = "$TIME";
		color = "rgba(69, 133, 136, 1)";
    font_size = 130;
    font_family = "${config.font}";
	  position = "0, -140";
    halign = "center";
    valign = "top";
	  }
	  # Date
	  {
    monitor = "DP-1";
    text = "cmd[update:1000] echo '<span>$(date `+%A, %d %B`)</span>'";
    color = "rgba(142, 192, 124, 1)";
    font_size = 30;
    font_family = "${config.font}";
    position = "0, 140";
    halign = "center";
    valign = "center";
	  }
	  # Profile Icon
	  {
	  monitor = "DP-1";
	  text = "";
    color = "rgba(250, 189, 47, 1)";
    font_size = 80;
    font_family = "${config.font}";
    position = "-10, 60";
		halign = "center";
	  valign = "center";
	  }
	  # User
	  {
  	monitor = "DP-1";
  	text = "$USER";
  	color = "rgba(231, 215, 173, 1)";
  	font_size = 25;
  	font_family = "${config.font}";
  	position = "0, -35";
  	halign = "center";
  	valign = "center";
  }
];


      };
    };
}
