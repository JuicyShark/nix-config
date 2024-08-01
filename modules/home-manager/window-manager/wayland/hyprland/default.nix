{
  inputs,
  pkgs,
  config,
  osConfig,
  ...
}: let
  terminal = "${pkgs.foot}/bin/foot";
  neorg = "${pkgs.foot}/bin/foot nvim -c 'Neorg index'";
  colour = config.stylix.base16Scheme;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprlock.nix
    ./binds.nix
    ./rules.nix
    ../anyrun.nix
    ../waybar.nix
    ../mako.nix
  ];

  xdg.mimeApps.enable = true;

  home.packages = with pkgs; [
    xorg.xrandr
    wl-clipboard
    wl-mirror
    wlr-randr
    wf-recorder
  ];

  services = {
    hyprpaper.enable = true;
    cliphist.enable = true;
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "never";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      inputs.hypr-plugins.packages.x86_64-linux.hyprbars
    ];

    settings = {
      "$mainMod" = "SUPER";
      "$meh" = "ALT SHIFT CTRL";
      "$hyper" = "ALT SHIFT CTRL SUPER";
      monitor = (
        if config.home.username == "jake"
        then [",highrr,0x0,1," "HDMI-A-1,1920x1080@60,auto-right,1"]
        else if osConfig.homelab.enable
        then ["HEADLESS-1,1920x1080@120,0x0,1"]
        else ["DP-1,highrr,0x0,1," "HDMI-A-1,highrr,-5120x0,1"]
      );
      input = {
        kb_layout = "us,us";
        follow_mouse = 1;
        touchpad.natural_scroll = "yes";
      };

      cursor = {
        inactive_timeout = 10;
        default_monitor = "DP-1";
      };

      general = {
        gaps_in =
          if config.home.username == "juicy"
          then "6, 12, 6, 12"
          else 8;
        gaps_out =
          if config.home.username == "juicy"
          then "10, 70, 35, 70"
          else 12;
        border_size = 4;
        no_border_on_floating = false;
        resize_corner = 0;
        resize_on_border = true;
        allow_tearing = false;
        no_focus_fallback = true;
        layout = "dwindle";
      };

      dwindle = {
        pseudotile = true;
        force_split = 2;
        preserve_split = true;
        no_gaps_when_only = 0;
        split_width_multiplier = "1.2";
        default_split_ratio = "1.25";
      };

      decoration = {
        drop_shadow = false;
        rounding = 9;
        active_opacity = 0.85;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;
        dim_special = 0.3;

        blur = {
          enabled = true;
          ignore_opacity = true;
          new_optimizations = true;
          size = 3;
          contrast = 0.8916;
          brightness = 0.8672;
          vibrancy = 0.2496;
          vibrancy_darkness = 0.15;
          passes = 3;
          special = true;
          popups = true;
        };
      };

      group = {
        groupbar = {
          font_size = config.stylix.fonts.sizes.desktop;
          height = 20;
          stacked = false;
          scrolling = false;
          gradients = true;
          priority = 2;
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
        swallow_regex = "^(terminal)$";
        new_window_takes_over_fullscreen = 2;
        disable_hyprland_logo = true;
        vrr = 0;
        vfr = false;
        font_family = "${config.stylix.fonts.serif.name}";
      };

      xwayland = {
        use_nearest_neighbor = false;
      };

      layerrule = [
        "animation fade,hyprpicker"
        "animation fade,selection"

        "animation fade,waybar"
        "blur,waybar"
        "ignorezero,waybar"

        "blur,notifications"
        "ignorezero,notifications"

        "blur,wofi"
        "ignorezero,wofi"

        "noanim,wallpaper"
      ];
      animations = {
        enabled = true;
        bezier = [
          "easein,0.1, 0, 0.5, 0"
          "easeinback,0.35, 0, 0.95, -0.3"

          "easeout,0.5, 1, 0.9, 1"
          "easeoutback,0.35, 1.35, 0.65, 1"

          "easeinout,0.45, 0, 0.55, 1"
        ];

        animation = [
          "fadeIn,1.15,3,easeout"
          "fadeLayersIn,1.15,3,easeoutback,"
          "layersIn,1.3,3,easeoutback,popin"
          "windowsIn,1.15,3,easeoutback,slide"

          "fadeLayersOut,1.15,3,easeinback,"
          "fadeOut,1.15,3,easein"
          "layersOut,1.3,3,easeinback,fade"
          "windowsOut,1.15,3,easeinback,slide"

          "border,1.15,3,easeout"
          "windowsMove,1.15,3,easeoutback"
          "workspaces,1.5,2.6,easeoutback,fade"
        ];
      };
      plugin = {
        hyprbars = {
          bar_height = 25;
          bar_color = "rgb(${colour.base01})";
          col.text = "rgb(${colour.base0B})";
          bar_title_enabled = true;
          bar_text_size = config.stylix.fonts.sizes.desktop;
          bar_text_font = "${config.stylix.fonts.monospace.name}";
          bar_text_align = "center";
          bar_buttons_alignment = "right";
          bar_part_of_window = true;
          bar_precedence_over_border = true;
          bar_padding = 6;
          bar_button_padding = 6;
          hyprbars-button = [
            "rgb(${colour.base0E}), 10, 󰖭, hyprctl dispatch killactive"
            "rgb(${colour.base06}), 10, , hyprctl dispatch fullscreen 1"
          ];
        };
      };

      exec-once =
        [
          "hyprpaper"
          "hypridle"
          "ags"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "steam"
          "[workspace 7 silent] tidal-hifi"
        ]
        ++ (
          if osConfig.hardware.keyboard.zsa.enable
          then [
            "[workspace 3 silent] keymapp"
            "[workspace 2 silent] ${neorg}"
            "[workspace 2 silent] ${terminal}"
            "[workspace 3 silent] signal-desktop"
            "[workspace 3 silent] discord"
            "[workspace 3 silent] qutebrowser --target window https://www.facebook.com"
            "[workspace 6 silent] qutebrowser --target window https://youtube.com"
          ]
          else [
            "polkit-gnome-authentication-agent-1"
            "[workspace 2 silent] obsidian"
            "[workspace 1 silent]firefox --new-window https://www.reddit.com"
            "[workspace 1 silent]firefox --new-window https://www.youtube.com"
          ]
        );

      exec = [
        "xrandr --output DP-1 --primary"
      ];
    };

    systemd = {
      variables = [
        "--all"
      ];

      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
