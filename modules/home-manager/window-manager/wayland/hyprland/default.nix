{
  inputs,
  pkgs,
  config,
  osConfig,
  ...
}: let
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
        "$mainMod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      ]
    )
    10);

  hyprFocus = import ../../../cli/nvim/plugins/vim-hypr-nav.nix {
    inherit (pkgs) stdenv fetchFromGitHub installShellFiles;
  };

  terminal = "${pkgs.foot}/bin/foot";
  neorg = "${pkgs.foot}/bin/foot nvim -c 'Neorg index'";
in {
  imports = [
    inputs.hyprland.homeManagerModules.default

    ./hyprlock.nix
    ./hyprpaper.nix
    ../ags-test
    #../waybar.nix
  ];

  xdg.mimeApps.enable = true;

  home.persistence = {
    "/persist${config.home.homeDirectory}" = {
      allowOther = true;
      directories = [
        "games"
        ".factorio"
        ".config/unity3d/Berserk Games/Tabletop Simulator"
        ".config/unity3d/IronGate/Valheim"
        ".local/share/Tabletop Simulator"
        ".local/share/Paradox Interactive"
        ".paradoxlauncher"
        ".local/share/Steam"
        ".local/share/osu"
      ];
    };
  };
  home.packages = with pkgs;
    [
      wl-clipboard
      wl-mirror
      wlr-randr
      wf-recorder
      ddcutil
      xsettingsd
      xorg.xprop
      networkmanager
    ]
    ++ (
      if osConfig.hardware.keyboard.zsa.enable
      then [
      ]
      else [
        which
        bun
        dart-sass
        fd
        fzf
        brightnessctl
        swww
        slurp
        wayshot
        swappy
        hyprpicker
        pavucontrol
        gtk3
      ]
    );

  services = {
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
      #inputs.hy3.packages.x86_64-linux.hy3
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
          passes = 4;
          special = true;
          popups = true;
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
        swallow_regex = "^(terminal)$";
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

      bind =
        [
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
          "$mainMod CTRL, S, layoutmsg, togglesplit"
          "$mainMod CTRL, R, layoutmsg, swapsplit"

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
        ]
        ++ (
          if config.home.username == "juicy"
          then [
            "$mainMod, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"
            "$meh, return, exec, ${terminal}"
            "$meh, T, exec, ${terminal}"
            "$meh, space, exec, ${pkgs.tofi}/bin/tofi-drun"
            "$meh, R, exec, ${pkgs.tofi}/bin/tofi-run"
            "$meh, D, exec, ${pkgs.discord}/bin/discord"
            "$meh, M, exec, ${pkgs.tidal-hifi}/bin/tidal-hifi"
            "$meh, B, exec, ${pkgs.bambu-studio}/bin/bambu-studio"
            "$meh, J, exec, [float; center] ${terminal} nvim -c 'Neorg journal today"
            "$meh, C, exec, [float; center] ${terminal} nvim"
            "$meh, N, exec, [float; center] ${terminal} nvim -c 'Neorg index'"
            "$meh, escape, exec, [float; size 950 650; move onscreen 100%-0;] ${terminal} ${pkgs.bottom}/bin/btm"
            "$meh, F, exec, [float; size 1650 850; center;] ${terminal} ${pkgs.yazi}/bin/yazi"
            "$meh, W, exec, ${pkgs.firefox}/bin/firefox"
            #"$meh, Q, exec, [group new;] ${pkgs.qutebrowser}/bin/qutebrowser"
            "$meh, period, exec, [float; size 1650 850; center;] ${terminal} ${pkgs.yazi}/bin/yazi"
            "$meh, slash, exec, ${terminal} nvim -c ${pkgs.fzf}/bin/fzf"
          ]
          else [
            "$mainMod SHIFT, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"

            # Quick launch
            "$mainMod, return, exec, ${terminal}"
            "$mainMod, space, exec, ags -t launcher"
            "$mainMod, O, exec, ${pkgs.obsidian}/bin/obsidian"
            "$mainMod, D, exec, ${pkgs.discord}/bin/discord"
            "$mainMod, M, exec, ${pkgs.tidal-hifi}/bin/tidal-hifi"
            "$mainMod, J, exec, [float; center] ${terminal} nvim -c 'Neorg journal today"
            "$mainMod, N, exec, [float; center] ${terminal} nvim -c 'Neorg index'"
            "$mainMod, escape, exec, [float; size 950 650; move onscreen 100%-0;] ${terminal} ${pkgs.bottom}/bin/btm"
            "$mainMod, F, exec, [float; size 1650 850; center;] ${terminal} ${pkgs.yazi}/bin/yazi"
            "$mainMod, W, exec, ${pkgs.firefox}/bin/firefox"
            "$mainMod, Q, exec, [group new;] ${pkgs.qutebrowser}/bin/qutebrowser"
            "$meh, period, exec, [float; size 1650 850; center;] ${terminal} ${pkgs.yazi}/bin/yazi"
            "$meh, slash, exec, ${terminal} nvim -c ${pkgs.fzf}/bin/fzf"
          ]
        )
        ++ workspaces;

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
        "$mainMod SHIFT, mouse:272, resizewindow"
      ];

      exec-once =
        [
          "hyprpaper"
          "hypridle"
          "ags"
          "steam"
          "atuin daemon"
          "atuin server start"
          "[workspace 7 silent] tidal-hifi"
        ]
        ++ (
          if osConfig.hardware.keyboard.zsa.enable
          then [
            "gnome-keyring-daemon --start --components=secrets"
            #"polkit-gnome-authentication-agent-1"

            "[workspace 2 silent] ${neorg}"
            "[workspace 2 silent] ${terminal}"
            "[workspace 3 silent] signal-desktop"
            "[workspace 3 silent] discord"
            "[workspace 3 silent] firefox --new-window https://www.facebook.com/"
            "[workspace 6 silent] qutebrowser --target window https://youtube.com"
            "[workspace 1 silent] firefox --new-window https://reddit.com"
          ]
          else [
            "polkit-gnome-authentication-agent-1"
            "[workspace 2 silent] obsidian"
            "armcord"
            "[workspace 1 silent]firefox --new-window https://www.reddit.com"
            "[workspace 1 silent]firefox --new-window https://www.youtube.com"
          ]
        );

      exec = [
        "xrandr --output DP-1 --primary"
      ];

      workspace =
        [
          "m[HDMI-A-1], gapsout:0, gapsin:0, border:false, rounding:false, decorate:false, shadow:false"
          "1, monitor:DP-1, default:true"
          "2, monitor:DP-1"
          "3, monitor:DP-1, defaultName:Social, bordersize:5, gapsin:15, gapsout:33"
          "4, monitor:DP-1, defaultName:Terminal, gapsin:0, gapsout:0, shadow:false, rounding:false"
          "5, monitor:DP-1, defaultName:Games, border:false, decorate:false, shadow:false, rounding:false, gapsin:0, gapsout:0"
          "6, monitor:HDMI-A-1, default:true"
          "7, monitor:HDMI-A-1"
          "8, monitor:HDMI-A-1"
          "9, monitor:HDMI-A-1"
          "0, monitor:HDMI-A-1"
        ]
        ++ (
          if osConfig.hardware.keyboard.zsa.enable
          then [
            "w[vt1] m[DP-1] r[1-3], gapsout:13 1050 33 1050"
            "w[vt2] m[DP-1] r[1-3], gapsout:13 400 33 400"
            "w[vt1] m[DP-1] r[4-4], gapsout:0 1330 0 1330"
            "w[vt1] m[DP-1] r[5-5], gapsout:0 830 0 830, gapsin:0"
          ]
          else []
        );

      windowrulev2 =
        [
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
          "tag +term, class:(terminal)"
          "tag +launcher, class:(steam)"

          # Do not idle when Gaming / playing media
          "idleinhibit always, tag:games"
          "idleinhibit always, tag:pinnedMedia"
          "idleinhibit focus, tag:media"

          # Transparency
          #"opacity 0.65 override, tag:term"
          "opacity 0.80, tag:social"
          "opacity 0.85, tag:music"
          "opacity 0.85 override 0.85 override 1.0 override, tag:browser"
          "opacity 1.00 override 1.00 override 1.0 override, tag:media"

          # Match tags to certain workspaces
          "monitor DP-1, tag:games"
          "noblur, tag:games"
          "xray 1, tag:games"
          "group deny, tag:games"
          "tile, tag:games"

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
        ]
        ++ (
          if osConfig.hardware.keyboard.zsa.enable
          then [
            # Dont allow windows to maximize unless specified
            "suppressevent maximize, class:^(.*)$"
            # Flating windows should have a title bar
            "plugin:hyprbars:nobar, floating:0"

            "workspace 3, tag:social"
            "workspace 5, class:^(steam_app.*)$"
            "workspace 5, fullscreen:1"
            "workspace 6, tag:music"
          ]
          else []
        );
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
