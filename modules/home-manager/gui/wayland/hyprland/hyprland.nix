{ config, pkgs, ... }:
let 
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
        "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
				"$mainMod CTRL, ${ws}, movetoworkspacesilent, ${toString (x +1)}"
      ]
    )
    10);
in {

	wayland.windowManager.hyprland.settings = {
		exec-once = [
			"hyprpaper"
			"hypridle"
			"waybar"
			"polkit-gnome-authentication-agent-1"
			"systemctl start --user logid.service"
			"[workspace 1 silent] firefox"
			"[workspace 1 silent] kitty"
			"[workspace 2 silent] steam"
			"[workspace 3 silent] signal-desktop"
		];

		xwayland.force_zero_scaling = true;
		misc.disable_hyprland_logo = true;
		input = {
			kb_layout = "us,us";
			#kb_variant = ""; 
			#kb_options = "";
			follow_mouse = 1;
			touchpad = {
				natural_scroll = "yes";
			};
		};
		general = {
			gaps_in = 0;
			gaps_out = 0;
			border_size = 3;
			resize_on_border = true;
			allow_tearing = true;
			no_focus_fallback = true;
			"col.inactive_border" = "0xE6${config.colorScheme.palette.base03}";
			"col.active_border" = "0xE6${config.colorScheme.palette.base0D}";
			layout = "dwindle";
		};
		decoration = {
			drop_shadow = false;
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
			"col.border_inactive" = "0xE6${config.colorScheme.palette.base03}";
			"col.border_active" = "0xE6${config.colorScheme.palette.base0B}";
			"col.border_locked_active" = "0xE6${config.colorScheme.palette.base0E}";
			"col.border_locked_inactive" = "0xE6${config.colorScheme.palette.base00}";
		
			groupbar = {
				enabled = false;
				font_family = config.font;
				gradients = true;
				height = 22;
				priority = 3;
				render_titles = true;
				scrolling = false;
				text_color = "0xff${config.colorScheme.palette.base05}";
				"col.inactive" = "0xE6${config.colorScheme.palette.base03}";
				"col.active" = "0xE6${config.colorScheme.palette.base0B}";
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
			vrr = "1";
		};

	
		"$mainMod" = "ALT";

		workspace = [
			"1, monitor:DP-1, default:true, defaultName:󰖟"
			"2, monitor:DP-1, defaultName:󰊴, decorate:false, layoutopt:orientation:left"
			"3, monitor:DP-1, defaultName:󰍥, gapsin:10, gapsout:20"
			"4, monitor:DP-1, defaultName:, border:4, on-created-empty:kitty"
			"5, monitor:DP-1, defaultName:"
			"6, monitor:DP-1, defaultName:, on-created-empty:tidal-hifi, gapsin:30, gapsout:75"
			"7, monitor:HDMI-A-1, default:true, name:"
			"special:scratchpad, gapsin:15, gapsout:75, bordersize:10, on-created-empty:kitty"
		];
	
			
		windowrulev2 = [			
			"suppressevent fullscreen, class:^(.*)$"
			"suppressevent maximize, class:^(.*)$"
			"idleinhibit always, class:^(steam_app.*)$"
			"idleinhibit focus, title:^(.*| WATCH ON BINGE —.*)$"
			"idleinhibit focus, title:^(.*- YouTube.*)$"
			"idleinhibit focus, title:^(Netflix -.*)$"
			"idleinhibit focus, title:^(Prime Video:.*)$"
			"idleinhibit focus, title:^(.*- Twitch.*)$"
			"idleinhibit always, title:^(Picture-in-Picture)$"

			"opacity 0.85, class:^(kitty)$"
			"opacity 0.85, class:^(steam)$"
			"opacity 0.9, class:^(Signal)$"
			"opacity 0.90, class:^(firefox)$"
			"opacity 1.0 override, title:^(.*| WATCH ON BINGE —.*)$"
			"opacity 1.0 override, title:^(.*- YouTube.*)$"
			"opacity 1.0 override, title:^(Netflix -.*)$"
			"opacity 1.0 override, title:^(Prime Video:.*)$"
			"opacity 1.0 override, title:^(.*- Twitch.*)$"
			"opacity 1.0 override, title:^(Picture-in-Picture)$"
			"tile, class:^(steam_app.*)$"
			"noborder, class:^(steam_app.*)$"
			"immediate, class:^(steam_app.*)$"
		];
		
		

		bind = [
			"SUPER SHIFT, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m region --clipboard-only"
			"SUPER CTRL, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m output --clipboard-only"
			"SUPER CTRL, C, exec, ${pkgs.hyprpicker}/bin/hyprpicker"
			"$mainMod, return, exec, ${pkgs.kitty}/bin/kitty"
			"$mainMod, T, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim '/home/juicy/documents/Notes/TODO Weekly List.md'"
			"$mainMod SHIFT, T, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c ObsidianToday"				
			"$mainMod, N, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c ObsidianNew"
			"$mainMod, escape, exec, [float; size 950 650; move onscreen 100%-0; bordercolor rgb('${config.colorScheme.palette.base0B}')] ${pkgs.kitty}/bin/kitty btop"
			"$mainMod, period, exec, [float; size 1650 850; center; bordercolor rgb('${config.colorScheme.palette.base0B}');] ${pkgs.kitty}/bin/kitty yazi"
			#"$mainMod, ?, exec, ${pkgs.kitty}/bin/kitty hyprkeys" #TODO implement keybind helper
			"$mainMod SHIFT, Q, killactive,"
			#"$mainMod, M, exit,"
			"$mainMod, P, togglefloating"
			"$mainMod SHIFT, P, pin" 
			"$mainMod, space, exec, anyrun"
			"$mainMod, B, exec, ${pkgs.firefox}/bin/firefox"
			"$mainMod SHIFT, B, exec, ${pkgs.qutebrowser}/bin/qutebrowser"
			"$mainMod, slash, exec, ${pkgs.kitty}/bin/kitty ${pkgs.neovim}/bin/nvim $(${pkgs.fzf}/bin/fzf))"
			", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 10%+"
			", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 10%-"
			", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
			", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
			# Move focus with mainMod + arrow keys
			"$mainMod, s, movefocus, l"
			"$mainMod, f, movefocus, r"
			"$mainMod, e, movefocus, u"
			"$mainMod, d, movefocus, d"
			"$mainMod, w, focusurgentorlast"
			
			#Master layout
			"$mainMod, r, layoutmsg, focusmaster master"
			"$mainMod SHIFT, r, layoutmsg, swapwithmaster master"
			"$mainMod, a, layoutmsg, mfact 0.483"
			"$mainMod SHIFT, a, layoutmsg, mfact 0.675"
			"$mainMod CTRL, s, layoutmsg, orientationleft"
			"$mainMod CTRL, f, layoutmsg, orientationright"
			"$mainMod CTRL, e, layoutmsg, orientationtop"
			"$mainMod CTRL, d, layoutmsg, orientationbottom"	
			"$mainMod CTRL, a, layoutmsg, orientationcenter"

			#Dwindle layout
			"$mainMod CTRL, s, layoutmsg, preselect l"
			"$mainMod CTRL, f, layoutmsg, preselect r"
			"$mainMod CTRL, e, layoutmsg, preselect u"
			"$mainMod CTRL, d, layoutmsg, preselect d"
			"$mainMod, a, pseudo"
			"$mainMod SHIFT, a, layoutmsg, swapsplit"

			# Resize windows with mainMod + SUPER + arrow keys
			"$mainMod SUPER, s, resizeactive, 25 0"
			"$mainMod SUPER, f, resizeactive, -25 0"
			"$mainMod SUPER, e, resizeactive, 0 -25"
			"$mainMod SUPER, d, resizeactive, 0 25"
			# Move windows with mainMod + shift + arrow keys
			"$mainMod SHIFT, s, movewindoworgroup, l"
			"$mainMod SHIFT, f, movewindoworgroup, r"
			"$mainMod SHIFT, e, movewindoworgroup, u"
			"$mainMod SHIFT, d, movewindoworgroup, d"

			"$mainMod, g, togglegroup"
			"$mainMod SHIFT, g, lockactivegroup, toggle"
			"$mainMod, tab, changegroupactive, f"
			"$mainMod SHIFT, tab, changegroupactive, b"
			# Scroll through existing workspaces with mainMod + scroll
			"$mainMod, mouse_down, workspace, e+1"
			"$mainMod, mouse_up, workspace, e-1"
			# Special Workspace 
			"$mainMod, grave, togglespecialworkspace, scratchpad"
			"$mainMod Shift, grave, movetoworkspace, special:scratchpad"
		]
		++ workspaces;

		# Move/resize windows with mainMod + LMB/RMB and dragging
		bindm = [
			"$mainMod, mouse:272, movewindow"
			"$mainMod, mouse:273, resizewindow"
			"$mainMod SHIFT, mouse:272, resizewindow"
		];
	};

xdg.configFile."hypr/hyprpaper.conf".text = ''
	preload = /home/juicy/nixos/modules/home-manager/gui/wayland/hyprland/backgrounds/arcade-background.png
	wallpaper = DP-1,/home/juicy/nixos/modules/home-manager/gui/wayland/hyprland/backgrounds/arcade-background.png
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
    		path = /home/juicy/nixos/modules/home-manager/gui/wayland/hyprland/backgrounds/arcade-background.png
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
