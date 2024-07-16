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
in {
  # Let it try to start a few more times
  systemd.user.services.waybar = {
    Unit.StartLimitBurst = 30;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    });
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = true;
        passthrough = false;
        height = 40;
        margin = "6";
        position = "top";
        modules-left =
          [
            #"custom/menu"
            "hyprland/workspaces"
            "custom/currentplayer"
            "custom/player"
          ];

        modules-center = [
          "cpu"
          #"custom/gpu" TODO see if nvidia can be read from script
          "memory"
          "clock"
          "wireplumber"
        ];

        modules-right = [
          "hyprland/submap"
          "custom/rfkill"
          "network"
          "tray"
          "custom/hostname"
        ];

        clock = {
          interval = 1;
          format = "{:%d/%m %H:%M:%S}";
          format-alt = "{:%Y-%m-%d %H:%M:%S}";
          on-click-left = "mode";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = " {usage}%";
        };
        "custom/gpu" = {
          interval = 5;
          exec = mkScript {script = "cat /sys/class/drm/card0/device/gpu_busy_percent";};
          format = "󰒋 {}%";
        };
        memory = {
          format = " {}%";
          interval = 5;
        };

        wireplumber = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          on-click = lib.getExe pkgs.pwvucontrol;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁 Eth";
          format-disconnected = "Disconnected";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };
        "custom/menu" = {
          interval = 1;
          return-type = "json";
          exec = mkScriptJson {
            text = "";
            class = let
              isFullScreen = "hyprctl activewindow -j | jq -e '.fullscreen' &>/dev/null";
            in "$(if ${isFullScreen}; then echo fullscreen; fi)";
          };
        };
        "custom/hostname" = {
          exec = mkScript {script = ''echo "$USER@$HOSTNAME"'';};
          on-click = mkScript {script = "systemctl --user restart waybar";};
        };
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = mkScriptJson {
            deps = [pkgs.playerctl];
            pre = ''
              player="$(playerctl status -f "{{playerName}}" 2>/dev/null || echo "No player active" | cut -d '.' -f1)"
              count="$(playerctl -l 2>/dev/null | wc -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = "󰓇 ";
            "ncspot" = "󰓇 ";
            "qutebrowser" = "󰖟 ";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
            "chromium" = " ";
          };
        };
        "custom/rfkill" = {
          interval = 1;
          exec-if = mkScript {
            deps = [pkgs.util-linux];
            script = "rfkill | grep '\<blocked\>'";
          };
        };
        "custom/player" = {
          exec-if = mkScript {
            deps = [pkgs.playerctl];
            script = "playerctl status 2>/dev/null";
          };
          exec = let
            format = ''{"text": "{{title}} - {{artist}}", "alt": "{{status}}", "tooltip": "{{title}} - {{artist}} ({{album}})"}'';
          in
            mkScript {
              deps = [pkgs.playerctl];
              script = "playerctl metadata --format '${format}' 2>/dev/null";
            };
          return-type = "json";
          interval = 2;
          max-length = 50;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤";
            "Stopped" = "󰓛";
          };
          on-click = mkScript {
            deps = [pkgs.playerctl];
            script = "playerctl play-pause";
          };
        };
      };
    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
   style = let
      #inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
      colors = config.colorScheme.palette;
      #toRGBA = color: opacity: "rgba(${hexToRGBString "," (lib.removePrefix "#" color)},${opacity})";
    in

      ''
        * {
          font-family: ${config.font};
          font-size: 13pt;
          padding: 0;
          margin: 0 0.4em;
        }

        window#waybar {
          padding: 0;
          border-radius: 0.5em;
          background-color: #${colors.base02};
          color: #${colors.base0D};
        }
        .modules-left {
          margin-left: -0.65em;
        }
        .modules-right {
          margin-right: -0.65em;
        }

        #workspaces button {
          background-color: #${colors.base02};
          color: #${colors.base0D};
          padding-left: 0.4em;
          padding-right: 0.4em;
          margin-top: 0.15em;
          margin-bottom: 0.15em;
        }
        #workspaces button.hidden {
          background-color: #${colors.base02};
          color: #${colors.base0E};
        }
        #workspaces button.focused,
        #workspaces button.active {
          background-color: #${colors.base0D};
          color: #${colors.base00};
        }

        #clock {
          padding-right: 1em;
          padding-left: 1em;
          border-radius: 0.5em;
        }

        #custom-menu {
          background-color: #${colors.base0D};
          color: #${colors.base00};
          padding-right: 1.5em;
          padding-left: 1em;
          margin-right: 0;
          border-radius: 0.5em;
        }
        #custom-menu.fullscreen {
          background-color: #${colors.base02};
          color: #${colors.base0E};
        }
        #custom-hostname {
          background-color: #${colors.base0D};
          color: #${colors.base0B};
          padding-right: 1em;
          padding-left: 1em;
          margin-left: 0;
          border-radius: 0.5em;
        }
        #custom-currentplayer {
          padding-right: 0;
        }
        #tray {
          color: #${colors.base0D};
        }
        #custom-gpu, #cpu, #memory {
          margin-left: 0.05em;
          margin-right: 0.55em;
        }
      '';
  };
}
