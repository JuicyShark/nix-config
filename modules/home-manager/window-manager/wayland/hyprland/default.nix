{ inputs, pkgs, hy3, osConfig, lib, config, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./keybinds.nix
    ./rules.nix
    ./autostart.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  config = lib.mkIf osConfig.desktop.enable {
    home. packages = with pkgs;
      [
        hyprpicker
        hyprlang
        hyprcursor
        hyprland-protocols
      ];

    wayland.windowManager.hyprland = {
      enable = true;
      #plugins = [ hy3.packages.x86_64-linux.hy3 ];
      settings = {
        monitor = [ ",highrr,0x0,1,bitdepth,10" "HDMI-A-1,disable"];
        xwayland.force_zero_scaling = true;
        input = { kb_layout = "us,us";
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
              "col.border_inactive" = "rgba(${config.colorScheme.palette.base03}ff)";
              "col.border_active" = "rgba(${config.colorScheme.palette.base0B}ff)";
              "col.border_locked_active" = "rgba(${config.colorScheme.palette.base0E}ff)";
              "col.border_locked_inactive" = "rgba(${config.colorScheme.palette.base00}ff)";
          groupbar = {
            enabled = false;
            font_family = config.font;
            gradients = true;
            height = 22;
            priority = 3;
            render_titles = true;
            scrolling = false;
            text_color = "rgba(${config.colorScheme.palette.base05}ff)";
            "col.inactive" = "rgba(${config.colorScheme.palette.base03}ff)";
            "col.active" = "rgba(${config.colorScheme.palette.base0B}ff)";
            };
          };

          dwindle = {
            pseudotile = "yes";
            force_split = 2;
            preserve_split = "yes";
            no_gaps_when_only = 1;
            split_width_multiplier = "1.15";
          };

          master = {
            new_is_master = false;
            no_gaps_when_only = 1;
            orientation = "center";
            inherit_fullscreen = false;
            always_center_master = true;
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
