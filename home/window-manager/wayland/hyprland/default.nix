{inputs, pkgs, config, osConfig, ... }:
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

  hyprFocus = import ../../../cli/nvim/plugins/vim-hypr-nav.nix {
    inherit (pkgs) stdenv fetchFromGitHub installShellFiles;
  };

  isJuicy = config.home.username == "juicy";
  colour = config.colorScheme.palette;
  hdrop =  "${inputs.hypr-scripts.packages.x86_64-linux.hdrop}/bin/hdrop";
  screenshot = "${inputs.hypr-scripts.packages.x86_64-linux.grimblast}/bin/grimblast";
  terminal = "${pkgs.kitty}/bin/kitty";

  neorg = "${pkgs.kitty}/bin/kitty nvim -c 'Neorg index'";
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.ags.homeManagerModules.default
    #../../../programs/anyrun.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  xdg.mimeApps.enable = true;

  home = {
		sessionVariables = {
			MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";

      GDK_BACKEND = "wayland,x11,*";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE  = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      #QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";

      #GTK_THEME = config.gtk.theme.name;
      #XCURSOR_THEME = config.gtk.cursorTheme.name;
      #XCURSOR_SIZE = config.gtk.cursorTheme.size;
      #HYPRCURSOR_THEME = config.gtk.cursorTheme.name;
      #HYPRCURSOR_SIZE = config.gtk.cursorTheme.size;
		};

    packages = with pkgs;[
        wl-clipboard
        wl-mirror
        wlr-randr
        wf-recorder
        ddcutil
        xsettingsd
        xorg.xprop
      ];
    };

    xdg.configFile."xsettingsd/xsettingsd.conf".text = ''
      Gdk/UnscaledDPI 98304
      Gdk/WindowScalingFactor 2
    '';

    programs.ags = {
      enable = true;
      configDir = ../../../../ags;
      extraPackages = with pkgs; [
        accountsservice
        gnome.gnome-bluetooth
      ];
    };

    services = {
      kdeconnect = {
        enable = true;
      };

      udiskie = {
        enable = true;
        automount = true;
        notify = true;
        tray = "auto";
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        #inputs.hy3.packages.x86_64-linux.hy3
        inputs.hypr-plugins.packages.x86_64-linux.hyprbars
      ];
      settings = {
        "$mainMod" = "SUPER";
        "$meh" = "ALT SHIFT CTRL";
        "$hyper" = "ALT SHIFT CTRL SUPER";


        monitor = ( if isJuicy then [ ",5120x1440,0x0,1,""HDMI-A-1,highrr,-5120x0,1"] else ["DP-1,2560x1440@165,0x0,1," "HDMI-A-1,1920x1080@60,2560x0,1"]);

        input = { kb_layout = "us,us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = "yes";
          };
        };

	      cursor = {
		      inactive_timeout = 10;
		      default_monitor = "DP-1";
	      };

        general = {
          gaps_in = 10;
          gaps_out = 25;
          border_size = 3;
          no_border_on_floating = false;
          resize_corner = 4;
          resize_on_border = true;
          allow_tearing = false;
          no_focus_fallback = true;
          "col.inactive_border" = "rgb(${config.colorScheme.palette.base02})";
          "col.active_border" = "rgb(${config.colorScheme.palette.base0D})";
          layout = "dwindle";
        };

        dwindle = {
          pseudotile = true;
          force_split = 2;
          preserve_split = true;
          no_gaps_when_only = 0;
          split_width_multiplier = "1.0";
          default_split_ratio = 1;
        };

        decoration = {
          drop_shadow = true;
          rounding = 9;
          active_opacity = 0.85;
          inactive_opacity = 0.85;
          fullscreen_opacity = 1.0;

          blur = {
            enabled = true;
            ignore_opacity = true;
            popups = true;
            new_optimizations = true;
            size = 3;
            contrast = 0.8916;
            brightness = 0.8672;
            vibrancy = 0.2496;
            vibrancy_darkness = 0.15;
            passes = 4;
          };
        };

        group = {
          "col.border_inactive" = "rgb(${config.colorScheme.palette.base03})";
          "col.border_active" = "rgb(${config.colorScheme.palette.base0B})";
          "col.border_locked_active" = "rgb(${config.colorScheme.palette.base0E})";
          "col.border_locked_inactive" = "rgb(${config.colorScheme.palette.base00})";

          groupbar = {
            font_size = 15;
            height = 20;
            stacked = false;
            scrolling = false;
            gradients = true;
		        priority = 2;
            text_color = "rgb(${config.colorscheme.palette.base05})";
            "col.inactive" = "rgb(${config.colorScheme.palette.base03})";
            "col.active" = "rgb(${config.colorScheme.palette.base0D})";
            "col.locked_active" = "rgb(${config.colorScheme.palette.base0E})";
            "col.locked_inactive" = "rgb(${config.colorScheme.palette.base02})";
          };
        };

        gestures = {
          workspace_swipe = "on";
        };

        binds = {
        	focus_preferred_method = 1;
        	movefocus_cycles_fullscreen = false;
		      window_direction_monitor_fallback = false;
        };

        misc = {
          enable_swallow = "true";
          swallow_regex = "^(kitty)$";
          new_window_takes_over_fullscreen = 2;
          disable_hyprland_logo = true;
          vrr = 2;
          vfr = true;
          font_family = "${config.font}";
        };

        xwayland = {
		      use_nearest_neighbor = true;
          #force_zero_scaling = true;
	      };

        plugin = {

          /*hy3 = {
            no_gaps_when_only = 1;
            node_collapse_policy = 2;
            group_inset = 0;
            tab_first_window = false;
            tabs = {
              height = 7;
              padding = 3;
              from_top = false;
              rounding = 3;
              render_text = false;
              text_center = true;
              text_font = "${config.font}";
              text_height = 11;
              text_padding = 3;
              # Tab Colours
              "col.active" = "rgba(${config.colorScheme.palette.base0D}ff)";
              "col.urgent" = "rgba(${config.colorScheme.palette.base0E}ff)";
              "col.inactive" = "rgba(${config.colorScheme.palette.base03}ff)";
              "col.text.active" = "rgba(${config.colorScheme.palette.base05}ff)";
              "col.text.urgent" = "rgba(${config.colorScheme.palette.base06}ff)";
              "col.text.inactive" = "rgba(${config.colorScheme.palette.base05}ff)";
            };
            autotile = {
              enable = true;
              ephemeral_groups = true;
              trigger_width = 1080;
              trigger_height = 550;
            };
          };*/

          hyprbars = {
            bar_height = 30;
            bar_color = "rgb(${config.colorScheme.palette.base00})";
            col.text = "rgb(${config.colorScheme.palette.base0B})";
            bar_title_enabled = true;
            bar_text_size = 15;
            bar_text_font = "${config.font}";
            bar_text_align = "center";
            bar_buttons_alignment = "right";
            bar_part_of_window = false;
            bar_precedence_over_border = true;
            bar_padding = 9;
            bar_button_padding = 9;
            hyprbars-button = [
              "rgb(${config.colorScheme.palette.base0E}), 10, 󰖭, hyprctl dispatch killactive"
              "rgb(${config.colorScheme.palette.base06}), 10, , hyprctl dispatch fullscreen 1"
            ];
          };
        };

        bind = [
	        # Move focus with mainMod + arrow keys
	        "$mainMod, left, exec, ${hyprFocus}/bin/vim-hypr-nav l"
	        "$mainMod, right, exec, ${hyprFocus}/bin/vim-hypr-nav r"
 	        "$mainMod, up, exec, ${hyprFocus}/bin/vim-hypr-nav u"
          "$mainMod, down, exec, ${hyprFocus}/bin/vim-hypr-nav d"

          "$mainMod, tab, changegroupactive, f"
          "$mainMod SHIFT, TAB, changegroupactive, b"

          # Move windows with mainMod + shift + arrow keys
	        "$mainMod SHIFT, left, movewindow, l"
	        "$mainMod SHIFT, right, movewindow, r"
	        "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"

          # Open next Window in given direction
  	      "$mainMod CTRL, left, layoutmsg, preselect l"
  	      "$mainMod CTRL, right, layoutmsg, preselect r"
  	      "$mainMod CTRL, up, layoutmsg, preselect u"
          "$mainMod CTRL, down, layoutmsg, preselect d"

          "$mainMod CTRL, G, togglegroup"

  	      # Resize windows with mainMod + SUPER + arrow keys
	        "$mainMod ALT SHIFT, left, resizeactive, 75 0"
	        "$mainMod ALT SHIFT, right, resizeactive, -75 0"
	        "$mainMod ALT SHIFT, up, resizeactive, 0 -75"
	        "$mainMod ALT SHIFT, down, resizeactive, 0 75"

          # layout / window management
          "$mainMod SHIFT, Q, killactive,"

          "$mainMod SHIFT, L, lockactivegroup, toggle"
          "$mainMod SHIFT, F, togglefloating"
          "$mainMod SHIFT, T, settiled"
	        "$mainMod SHIFT, P, pin"
          "$mainMod SHIFT, O, toggleopaque"



          # Media
	        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
	        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
	        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

          # Buggy with hy3
          "$mainMod, grave, togglespecialworkspace, special:scratchpad"
          "$mainMod Shift, grave, movetoworkspace, special:scratchpad"

        ]
        # Check if Nix config has hardware.keyboard.zsa.enable true or false
        # osConfig refers to Nix config in Home-Manager
        # config refers to the config you are in Nix/Home
        ++ (if osConfig.hardware.keyboard.zsa.enable then [
	        "$mainMod CTRL, S, layoutmsg, togglesplit"
          "$mainMod CTRL, R, layoutmsg, swapsplit"

          "$mainMod, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"

          # Quick launch
          "$meh, return, exec, ${terminal}"
          "$meh, T, exec, ${terminal}"
          "$meh, space, exec, ags -t applauncher"
          "$meh, O, exec, ags -t applauncher"
	        "$meh, J, exec, [float; center] ${terminal} nvim -c 'Neorg journal today"
          "$meh, N, exec, [float; center] ${terminal} nvim -c 'Neorg index'"
	        "$meh, escape, exec, [float; size 950 650; move onscreen 100%-0;] ${terminal} ${pkgs.bottom}/bin/btm"
	        "$meh, F, exec, [float; size 1650 850; center;] ${terminal} ${pkgs.yazi}/bin/yazi"
	        "$meh, W, exec, ${pkgs.firefox}/bin/firefox"
          "$meh, Q, exec, [group new;] ${pkgs.qutebrowser}/bin/qutebrowser"
          "$meh, slash, exec, ${terminal} nvim $(${pkgs.fzf}/bin/fzf))"
        ] else [
          "$mainMod SHIFT, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"

          # Quick launch
          "$mainMod, return, exec, ${terminal}"
          "$mainMod, T, exec, ${terminal}"
          "$mainMod, space, exec, ags -t applauncher"
          "$mainMod, O, exec, ags -t applauncher"
	        "$mainMod, J, exec, [float; center] ${terminal} nvim -c 'Neorg journal today"
          "$mainMod, N, exec, [float; center] ${terminal} nvim -c 'Neorg index'"
	        "$mainMod, escape, exec, [float; size 950 650; move onscreen 100%-0;] ${terminal} ${pkgs.bottom}/bin/btm"
	        "$mainMod, F, exec, [float; size 1650 850; center;] ${terminal} ${pkgs.yazi}/bin/yazi"
	        "$mainMod, W, exec, ${pkgs.firefox}/bin/firefox"
          "$mainMod, Q, exec, [group new;] ${pkgs.qutebrowser}/bin/qutebrowser"
          "$mainMod, slash, exec, ${terminal} nvim $(${pkgs.fzf}/bin/fzf))"
        ]) ++ workspaces;

		    # Move/resize windows with mainMod + LMB/RMB and dragging
		    bindm = [
		  	  "$mainMod, mouse:272, movewindow"
		  	  "$mainMod, mouse:273, resizewindow"
		  	  "$mainMod SHIFT, mouse:272, resizewindow"
        ];

 exec-once = [
        	"hyprpaper"
		      "hypridle"
          "ags"
          "polkit-gnome-authentication-agent-1"
          "[workspace 1 silent; group deny] firefox --new-window"
          "[workspace 1 silent;] ${neorg}"

          "[workspace 2 silent; group deny] firefox --new-window"
          "[workspace 2 silent;] bambu-studio"

          "[workspace 3 silent; group new] ${terminal}"
          "[workspace 3 silent; group new] qutebrowser --target window https://search.brave.com"
          "[workspace 3 silent; group deny] ${terminal} ya"
         	#

          "[workspace 4 silent] signal-desktop"
          "[workspace 4 silent] firefox --new-window https://www.facebook.com/"
          #"[workspace 3 silent] firefox --new-window https://discord.com/"
          "[workspace silent 4] discord"
          "[workspace silent 6] steam"
          "[workspace 6 silent] tidal-hifi"
          "[workspace 6 silent] ${terminal} ncmcpp -s browse"
          "[workspace 6 silent] ${terminal} cava"

          "[workspace 7 silent; group deny] qutebrowser --target window https://youtube.com"
	      ];
  exec = [
    "xrandr --output DP-1 --primary"
  ];
        workspace = [
          "m[HDMI-A-1], gapsout:0, gapsin:0, border:false, rounding:false, decorate:false, shadow:false"

          "1, monitor:DP-1, default:true"
  	      "2, monitor:DP-1"
  	      "3, monitor:DP-1, defaultName:Terminal, gapsin:0, gapsout:0, shadow:false, rounding:false"
          "4, monitor:DP-1, defaultName:Social, bordersize:6, gapsin:15, gapsout:75"
          "5, monitor:DP-1, defaultName:Games, border:false, decorate:false, shadow:false, rounding:false, gapsin:0, gapsout:0"
          "6, monitor:DP-1, defaultName:Misc, bordersize:9, gapsin:30, gapsout:75"
  	      "7, monitor:HDMI-A-1, default:true, defaultName:TV"

	        # 5120x1440 Monitor on  DP-1 try to somewhat center windows based on
          # Visible windows

          "w[vt1] m[DP-1] r[1-4], gapsout:25 1000 25 1000"
          "w[vt2-3] m[DP-1] r[1-4], gapsout:25 400 25 400"
          "w[vt1] m[DP-1] r[5-5], gapsout:0 780 0 780, gapsin:0"


        ];

        windowrulev2 = [
          # Dont allow windows to maximize unless specified
          "suppressevent maximize, class:^(.*)$"
          # Flating windows should have a title bar
          "plugin:hyprbars:nobar, floating:0"

          #Tagging windows
          "tag +games, class:^(steam_app.*)$"
          "tag +games, class:(Waydroid)"
	        "tag +games, class:(osu!)"

	        "tag +music, class:^(tidal-hifi)$"
	        "tag +music, title:^(ncmpcpp.*)$"

	        "tag +media, tag:games"
          "tag media, title:^(.*WATCH ON BINGE —.*)$"
          "tag media, title:^(.*- YouTube.*)$"
          "tag media, title:^(Netflix -.*)$"
          "tag media, title:^(Prime Video.*)$"
          "tag media, title:^(.*- Twitch.*)$"
          "tag +media, title:^(Picture-in-Picture)$"
          "tag +media, class:(mpv)"

          "tag +pinnedMedia, title:(Picture-in-Picture)$"
          "tag +pinnedMedia, class:(mpv)"

	        "tag +social, class:^(Signal)$"
	        "tag +social, class:^(discord)$"
          "tag +social, title:^(https://www.facebook.com.*)$ class:^(org.qutebrowser.qutebrowser)$"

	        "tag +browser, class:(org.qutebrowser.qutebrowser)"
	        "tag +browser, class:(firefox)"

          "tag +term, class:(kitty)"

          "tag +launcher, class:(steam)"

          # Do not idle when Gaming / playing media
          "idleinhibit always, tag:games"
	        "idleinhibit always, tag:pinnedMedia"
	        "idleinhibit focus, tag:media"

          # Transparency
  	      "opacity 0.85 override, tag:term"
	        "opacity 0.90, tag:social"
	        "opacity 0.90, tag:music"
	        "opacity 0.93 override 0.90 override 1.0 override, tag:browser"
	        "opacity 1.00 override 1.00 override 1.0 override, tag:media"

          # Match tags to certain workspaces
	        "monitor DP-1, tag:games"
	        "workspace 3, tag:social"
          "workspace 5, tag:games"

	        "workspace 5, fullscreen:1"
          "workspace 6, tag:music"
          #"group set, tag:browser"

          # Disable potentially GPU intensive options
          # Do not allow to be added to groups
          # Fix xwayland displaing incorrect res
          "noblur, tag:games"
          "xray 1, tag:games"
	        "group deny, tag:games"
          #"nomaxsize, tag:games"
          "tile, tag:games"
          #"suppressevent fullscreen, tag:games"

          # Pinned Media (mainly videos doing PnP)
          # Disable decorations and bar
          # ensure pinned between workspaces
          "float, tag:pinnedMedia"
          "pin, tag:pinnedMedia"
          "noborder, tag:pinnedMedia"
          "plugin:hyprbars:nobar, tag:pinnedMedia"
          "maxsize 2208 1242, tag:pinnedMedia"
          "minsize 640 480, tag:PinnedMedia"
          "move onscreen 100%-w-50, tag:PinnedMedia"
          #"keepaspectratio, tag:pinnedMedia"
          "suppressevent fullscreen, tag:pinnedMedia"

          "float, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden —.*)$"
          "size 550 750, title:^(Extension: (Bitwarden - Free Password Manager) - Bitwarden —.*)$"
        ];
      };

      systemd = {
      variables = [
        "--all"
      ];

      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
        "systemctl --user start xsettingsd.service && echo 'Xft.dpi: 192' | xrdb -merge && xprop -root -format _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2"
        ];
      };
    };
  }


