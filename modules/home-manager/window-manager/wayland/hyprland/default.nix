{system, inputs, pkgs, osConfig, lib, config, ... }:
{
  imports = [
 #   inputs.hyprland.homeManagerModules.default

    ./keybinds.nix
    ./rules.nix
    ./autostart.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  config = lib.mkIf osConfig.desktop.enable {
    home.packages = with pkgs;
      [
	      wl-clipboard
	      wl-mirror
 	      wlr-randr
    	  wf-recorder
        tomlplusplus
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [ ",highrr,0x0,1,""HDMI-A-1,disable"];
        xwayland.force_zero_scaling = true;
        input = { kb_layout = "us,us";
            follow_mouse = 1;
            touchpad = {
              natural_scroll = "yes";
              };
            };

            general = {
              gaps_in = 6;
              gaps_out = 25;
              border_size = 3;
              no_border_on_floating = true;
              resize_corner = 4;
              resize_on_border = true;
              allow_tearing = false;
              no_focus_fallback = true;
              "col.inactive_border" = "rgba(${config.colorScheme.palette.base02}ff)";
              "col.active_border" = "rgba(${config.colorScheme.palette.base0D}ff)";
              layout = "dwindle";
            };

          dwindle = {
            pseudotile = "yes";
            force_split = 2;
            preserve_split = "yes";
            no_gaps_when_only = 1;
            split_width_multiplier = "1.15";
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
              "col.border_inactive" = "rgba(${config.colorScheme.palette.base03}ff)";
              "col.border_active" = "rgba(${config.colorScheme.palette.base0B}ff)";
              "col.border_locked_active" = "rgba(${config.colorScheme.palette.base0E}ff)";
              "col.border_locked_inactive" = "rgba(${config.colorScheme.palette.base00}ff)";
              groupbar = {
                font_size = 10;
                height = 16;
                #stacked = true;
                scrolling = false;
                gradients = true;
                text_color = "rgb(${config.colorscheme.palette.base05})";
             "col.inactive" = "rgba(${config.colorScheme.palette.base01}C9)";
              "col.active" = "rgba(${config.colorScheme.palette.base0D}C9)";
              "col.locked_active" = "rgba(${config.colorScheme.palette.base0E}ff)";
              "col.locked_inactive" = "rgba(${config.colorScheme.palette.base02}ff)";
              };
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
            new_window_takes_over_fullscreen = 2;
            disable_hyprland_logo = true;
            vrr = 0;
            vfr = true;
            #font_family = "${config.font}";
          };
        };

        systemd = {
          variables = ["--all"
        ];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };

};

}
