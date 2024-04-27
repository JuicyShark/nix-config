{ config,  ... }:
{
  imports = [
    ./keybinds.nix
    ./rules.nix
    ./autostart.nix
  ];

	wayland.windowManager.hyprland.settings = {
		xwayland.force_zero_scaling = true;
		misc.disable_hyprland_logo = true;
		input = {
			kb_layout = "us,us";
			follow_mouse = 1;
			touchpad = {
				natural_scroll = "yes";
			};
		};
		general = {
			gaps_in = 7.5;
			gaps_out = 25;
      border_size = 3;
      no_border_on_floating = true;
      resize_corner = 4;
      no_cursor_warps = true;
			resize_on_border = true;
			allow_tearing = true;
			no_focus_fallback = true;
			"col.inactive_border" = "rgba(${config.colorScheme.palette.base03}ff)";
			"col.active_border" = "rgba(${config.colorScheme.palette.base0D}ff)";
			layout = "dwindle";
		};
		decoration = {
      drop_shadow = true;
      rounding = 8;
			blur = {
				enabled = true; 
				size = 10;
    		contrast = 0.8916;
    		brightness = 0.8672;
    		vibrancy = 0.2496;
    		vibrancy_darkness = 0.15;
				passes = 2;
				xray = false;
				};
		};
		group = {
			"col.border_inactive" = "0xff${config.colorScheme.palette.base03}";
			"col.border_active" = "0xff${config.colorScheme.palette.base0B}";
			"col.border_locked_active" = "0xff${config.colorScheme.palette.base0E}";
			"col.border_locked_inactive" = "0xff${config.colorScheme.palette.base00}";
		
			groupbar = {
				enabled = false;
				font_family = config.font;
				gradients = true;
				height = 22;
				priority = 3;
				render_titles = true;
				scrolling = false;
				text_color = "0xff${config.colorScheme.palette.base05}";
				"col.inactive" = "0xff${config.colorScheme.palette.base03}";
				"col.active" = "0xff${config.colorScheme.palette.base0B}";
			};
		};
		dwindle = {
			pseudotile = "yes";
			force_split = "2";
			preserve_split = "yes";
			no_gaps_when_only = 1;
			split_width_multiplier = "1.08";
		};
		master = {
			new_is_master = "false";
			no_gaps_when_only = "1";
			orientation = "center";
			inherit_fullscreen = "false";
			always_center_master = "true";
		};
		
		gestures = {
			workspace_swipe = "on";
		};
		binds = {
			focus_preferred_method = 1;
			movefocus_cycles_fullscreen = false;
		};
		misc = {
			enable_swallow = "true";
			swallow_regex = "^(kitty)$";
			new_window_takes_over_fullscreen = "2";
      vrr = "0";
      vfr = false;
    };

  };

xdg.configFile."hypr/hyprpaper.conf".text = ''
	preload = ${config.home.homeDirectory}/nixos/modules/home-manager/window-manager/wayland/hyprland/backgrounds/arcade-background.png
	wallpaper = DP-1,${config.home.homeDirectory}/nixos/modules/home-manager/window-manager/wayland/hyprland/backgrounds/arcade-background.png
	splash = true
'';
	
xdg.configFile."hypr/hypridle.conf".text = ''
	general {
   		lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
   		before_sleep_cmd = loginctl lock-session    # lock before suspend.
   		after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
	}
	listener {
	   	timeout = 900                                 # 15min
    		on-timeout = loginctl lock-session            # lock screen when timeout has passed
	}
	listener {
	    	timeout = 1200                                 # 20 min
    		on-timeout = hyprctl dispatch dpms off        # screen off when timeout has passed
    		on-resume = hyprctl dispatch dpms on          # screen on when activity is detected after timeout has fired.
	}
'';


xdg.configFile."hypr/hyprlock.conf".text = ''
	background {
    		monitor = DP-1
    		path = ${config.home.homeDirectory}/nixos/modules/home-manager/window-manager/wayland/hyprland/backgrounds/arcade-background.png
    		blur_passes = 2
    		contrast = 0.8916
    		brightness = 0.8672
    		vibrancy = 0.2496
    		vibrancy_darkness = 0.15
	}

	general {
	    	no_fade_in = false
    		grace = 0
    		disable_loading_bar = false
	}

	input-field {
	    	monitor = DP-1
    		size = 450, 75
    		outline_thickness = 2
    		dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
    		dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
    		dots_center = true
    		outer_color = rgba(0, 0, 0, 0)
    		inner_color = rgba(30, 30, 46, 0.3)
    		font_color = rgb(200, 200, 200)
    		fade_on_empty = false
    		placeholder_text = <i><span foreground="##ffffff99">Welcome back</span></i>
   		  hide_input = false
    		position = 0, -120
    		halign = center
    		valign = center
	}

	label {
	    	monitor = DP-1
    		text = $TIME
		color = rgba(69, 133, 136, 1)
   		font_size = 130
    		font_family = "${config.font}"
		position = 0, -140
    		halign = center
    		valign = top
	}
	# Date
	label {
   		monitor = DP-1
   		text = cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"
    		color = rgba(142, 192, 124, 1)
    		font_size = 30
    		font_family = "${config.font}"
    		position = 0, 140
    		halign = center
    		valign = center
	}	
	# Profile Icon
	label {
	    	monitor = DP-1
	    	text =  
    		color = rgba(250, 189, 47, 1)
    		font_size = 80
    		font_family = "${config.font}"
    		position = -10, 60
		halign = center
	    	valign = center
	}
	# User
	label {
  		monitor = DP-1
  		text = $USER
  		color = rgba(231, 215, 173, 1)
  		font_size = 25
  		font_family = "${config.font}"
  		position = 0, -35
  		halign = center
  		valign = center
	}
'';
}
