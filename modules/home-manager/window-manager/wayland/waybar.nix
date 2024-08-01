{
  config,
  lib,
  pkgs,
  ...
}: let
  commonDeps = with pkgs; [coreutils gnugrep systemd];
  # Function to simplify making waybar outputs
  mkScript = {
    name ? "script",
    deps ? [],
    script ? "",
  }:
    lib.getExe (pkgs.writeShellApplication {
      inherit name;
      text = script;
      runtimeInputs = commonDeps ++ deps;
    });
  # Specialized for JSON outputs
  mkScriptJson = {
    name ? "script",
    deps ? [],
    pre ? "",
    text ? "",
    tooltip ? "",
    alt ? "",
    class ? "",
    percentage ? "",
  }:
    mkScript {
      inherit name;
      deps = [pkgs.jq] ++ deps;
      script = ''
        ${pre}
        jq -cn \
          --arg text "${text}" \
          --arg tooltip "${tooltip}" \
          --arg alt "${alt}" \
          --arg class "${class}" \
          --arg percentage "${percentage}" \
          '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      '';
    };
  colors = config.stylix.base16Scheme;
in {
  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitBurst = 30;
  };
  home.packages = with pkgs; [
    playerctl
  ];
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    });
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = true;
        output = [
          "DP-1"
        ];
        passthrough = false;
        height = 38;
        margin = null;
        position = "top";
        modules-left = [
          "custom/menu"
          "hyprland/workspaces"
        ];

        modules-center = [
          "hyprland/window"
        ];

        modules-right = [
          "tray"
          "idle_inhibitor"
          "wireplumber"
          "network"
          "cpu"
          "custom/gpu"
          "memory"
          "user"
          "clock"
        ];
        "custom/menu" = {
          format = "";
          on-click = mkScript {script = "anyrun";};
        };
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = false;
          sort-by = "number";
          format = "<span color='#${colors.base0D}'>{icon}</span> [ {windows} ]";
          format-window-separator = "  ";
          window-rewrite-default = "";
          window-rewrite = {
            "title<.*youtube.*>" = "";
            "title<.*github.*>" = "";
            "title<Facebook -.*>" = "";
            "class<discord>" = "";
            "class<signal-desktop>" = "󰭹";
            "class<steam>" = "󰓓";
            "class<firefox>" = "";
            "class<org.qutebrowser.qutebrowser>" = "";
            "class<terminal>" = "";
            "class<kitty>" = "";
            "class<kitty> title<.*nvim>" = "";
            "title<.*Yazi:.*>" = "";
            "class<thunar>" = "";
            "code" = "󰨞";
          };
        };

        "hyprland/window" = {
          icon-size = 35;
          format = "{}";
          rewrite = {
            "Facebook -(.*)" = "<span color='#${colors.base0B}'> </span><i>$1</i>";
            "(.*) - YouTube" = "<span color='#${colors.base0B}'>󰗃 </span><i>$1</i>";
            "(.*) - Mozilla Firefox" = "<span color='#${colors.base0B}'> </span><i>$1</i>";
            "foot(.*)" = "<span color='#${colors.base0B}'> </span><i>$1</i>";
            "kitty(.*)" = "<span color='#${colors.base0B}'> </span><i>$1</i>";
            "nvim(.*)" = "<span color='#${colors.base0B}'> </span><i>$1</i>";
            "Yazi:(.*)" = "<span color='#${colors.base0B}'> </span><i>$1</i>";
          };
          separate-outputs = true;
        };

        clock = {
          interval = 60;
          format = "{:%H:%M  }";
          format-alt = "{:%m/%d %H:%M - :%Y}";
          on-click-left = "mode";
          tooltip-format = ''<tt>{calendar}</tt>'';
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#${colors.base0E}'><b>{}</b></span>";
              days = "<span color='#${colors.base05}'>{}</span>";
              weeks = "<span color='#${colors.base0C}'>W{}</span>";
              weekdays = "<span color='#${colors.base0A}'><b>{}</b></span>";
              today = "<span color='#${colors.base0B}'><b><u>{}</u></b></span>";
            };
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        cpu = {
          format = "<span color='#${colors.base0B}'> </span>{usage}%";
          interval = 5;
          on-click = lib.getExe pkgs.bottom;
        };
        "custom/gpu" = {
          interval = 5;
          exec = mkScript {script = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader | cut -b 1-2";};
          format = "<span color='#${colors.base0B}'>󰒋 </span>{}%";
          on-click = "hyprctl dispatch exec ${pkgs.bottom}/bin/btm";
        };
        memory = {
          format = "<span color='#${colors.base0B}'> </span>{}%";
          interval = 5;
          on-click = lib.getExe pkgs.bottom;
        };

        wireplumber = {
          format = "<span color='#${colors.base0B}'>{icon}</span> {volume}%";
          format-icons = [" " "󰖀 " "󰕾 " " "];
          format-muted = "   0%";
          on-click = lib.getExe pkgs.pwvucontrol;
          max-volume = 125;
        };

        network = {
          interval = 5;
          format-wifi = "<span color='#${colors.base0B}'> </span> {bandwidthDownBits}";
          format-ethernet = "<span color='#${colors.base0B}'>󰈁</span> {bandwidthDownBits}";
          format-disconnected = "<span color='#${colors.base08}'> </span> WLAN 404 <span color='#${colors.base08}'> </span>";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };

        tray = {
          icon-size = 22;
          spacing = 8;
        };
        user = {
          format = "{user} ↑ {work_d} days";
          on-click = mkScript {script = "systemctl --user restart waybar";};
          interval = 60;
          height = 30;
          width = 30;
          icon = true;
        };

        systemd-failed-units = {
          hide-on-ok = true;
          format = "✗ {nr_failed}";
          system = true;
          user = true;
        };
      };
    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = ''
      * {
        font-family: ${config.stylix.fonts.sansSerif.name};
        font-size: 16pt;
        padding: 0;
        margin: 0em;
      }
      .modules-left, .modules-right {
        font-size: 18pt;
      }
      window#waybar {
              padding: 0;
              background-color: #${colors.base00};
              color: #${colors.base00};
      }
      #custom-menu {
              font-size: 22pt;
              padding: 0.1em;
              margin-right: 0;
              background-color: #${colors.base00};
              color: #${colors.base0D};
      }
      #workspaces button {
            font-size: 22pt;
            border-left: 3px solid #${colors.base01};
            background-color: #${colors.base00};
            border-radius: 0;
            color: #${colors.base05};
            padding-right: 0.3em;
            padding-left: 0.3em;
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: #${colors.base01};
        color: #${colors.base0B};
        border-left: 3px solid #${colors.base00};
      }
      #workspaces button.urgent {
        background-color: #${colors.base0E};
        color: #${colors.base05};
        border-left: 3px solid #${colors.base00};
      }
      #workspaces button.inactive {
        color: #${colors.base04};
        border-left: 3px solid #${colors.base00};
      }
            #mpris.default {
              font-weight: bold;
              color: #${colors.base01};
            }
            #window {
              color: #${colors.base0D};
              border-radius: 20px;
              padding-left: 10px;
              padding-right: 10px;
            }
            #user {
              border-left: 2px solid #${colors.base01};
              background-color: #${colors.base0D};
              color: #${colors.base00};
              padding-right: 1.25em;
              padding-left: 1.25em;
              margin-left: 0;
              }
            #tray {
              color: #${colors.base01};
              padding-right: 1.25em;
              padding-left: 1.25em;
            }
            #clock {
              padding-right: 1.25em;
              padding-left: 1.25em;
              background-color: #${colors.base0D};
              color: #${colors.base00};
            }
            #custom-gpu, #cpu, #memory, #wireplumber, #network {
              border-left: 2px solid #${colors.base01};
              background-color: #${colors.base00};
              color: #${colors.base04};
              font-weight: bold;
              padding-right: 1.25em;
              padding-left: 1.25em;
            }
    '';
  };
}
