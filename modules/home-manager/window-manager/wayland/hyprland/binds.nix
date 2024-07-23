{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: let
  terminal = "${pkgs.foot}/bin/foot";
  neorg = "${pkgs.foot}/bin/foot nvim -c 'Neorg index'";
  hyprFocus = import ../../../cli/nvim/plugins/vim-hypr-nav.nix {
    inherit (pkgs) stdenv fetchFromGitHub installShellFiles;
  };
in {
  wayland.windowManager.hyprland.settings = {
    bind = let
      wp = lib.getExe' pkgs.wireplumber "wpctl";
      defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
      appLaunchBind = (
        if osConfig.hardware.keyboard.zsa.enable
        then "ALT SHIFT CTRL"
        else "SUPER"
      );

      workspaces = [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
        "F1"
        "F2"
        "F3"
        "F4"
        "F5"
        "F6"
        "F7"
        "F8"
        "F9"
        "F10"
        "F11"
        "F12"
      ];
      # Map keys (arrows and hjkl) to hyprland directions (l, r, u, d)
      directions = rec {
        left = "l";
        right = "r";
        up = "u";
        down = "d";
        h = left;
        l = right;
        k = up;
        j = down;
      };
    in
      [
        # Change Split Ratio for new splits
        "SUPER,minus,splitratio,-0.25"
        "SUPERSHIFT,minus,splitratio,-0.3333333"
        "SUPER,equal,splitratio,0.25"
        "SUPERSHIFT,equal,splitratio,0.3333333"

        # Group Settings
        "SUPERCONTROL, G, togglegroup"
        "SUPER, tab, changegroupactive, f"
        "SUPERSHIFT, tab, changegroupactive, b"
        "SUPERCONTROL, S, layoutmsg, togglesplit"
        "SUPERCONTROL, R, layoutmsg, swapsplit"

        # Resize windows with mainMod + SUPER + arrow keys

        "SUPER ALT SHIFT, left, resizeactive, 75 0"
        "SUPER ALT SHIFT, right, resizeactive, -75 0"
        "SUPER ALT SHIFT, up, resizeactive, 0 -75"
        "SUPER ALT SHIFT, down, resizeactive, 0 75"

        # layout / window management
        "SUPER SHIFT, Q, killactive,"
        "SUPER SHIFT, L, lockactivegroup, toggle"
        "SUPER SHIFT, F, togglefloating"
        "SUPER SHIFT, P, pin"
        "SUPER SHIFT, O, toggleopaque"

        # Media
        "SUPER, XF86AudioRaiseVolume, exec, ${wp} set-volume @DEFAULT_SINK@ 5%+"
        "SUPER, XF86AudioLowerVolume, exec, ${wp} set-volume @DEFAULT_SINK@ 5%-"
        "SUPER, XF86AudioMute, exec, ${wp} set-mute @DEFAULT_SINK@ toggle"
        "SUPER, XF86AudioMicMute, exec, ${wp} set-mute @DEFAULT_SOURCE@ toggle"

        # Default Apps
        "${appLaunchBind}, Return, exec, ${terminal}"
        "${appLaunchBind}, T, exec, ${terminal}"
        "${appLaunchBind}, E, exec, ${terminal} -c nvim"
        "${appLaunchBind}, W, exec, ${pkgs.firefox}/bin/firefox"
        "${appLaunchBind}, Q, exec, ${pkgs.qutebrowser}/bin/qutebrowser"
        "${appLaunchBind}, D, exec, ${pkgs.discord}/bin/discord"
        "${appLaunchBind}, M, exec, ${pkgs.tidal-hifi}/bin/tidal-hifi"
        # "${appLaunchBind}, Print, exec, ${grimblast} --notify --freeze copy area"
      ]
      ++
      /*
         # Notification manager
      (
        let
          makoctl = lib.getExe' config.services.mako.package "makoctl";
        in
          lib.optionals config.services.mako.enable [
            "SUPER,w,exec,${makoctl} dismiss"
            "SUPERSHIFT,w,exec,${makoctl} restore"
          ]
      )
      ++
      */
      # Launcher
      (
        let
          wofi = lib.getExe config.programs.wofi.package;
        in
          lib.optionals config.programs.wofi.enable [
            "${appLaunchBind}, Space, exec, ${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
            "${appLaunchBind}, S, exec, specialisation $(specialisation | ${wofi} -S dmenu)"
            "${appLaunchBind}, R, exec, ${wofi} -S run"
          ]
          ++ (
            let
              pass-wofi = lib.getExe (pkgs.pass-wofi.override {pass = config.programs.password-store.package;});
            in
              lib.optionals config.programs.password-store.enable [
                "${appLaunchBind}, semicolon, exec, ${pass-wofi}"
                "${appLaunchBind}, colon, exec, ${pass-wofi} fill"
              ]
          )
          ++ (
            let
              cliphist = lib.getExe config.services.cliphist.package;
            in
              lib.optionals config.services.cliphist.enable [
                ''${appLaunchBind}, c, exec, selected=$(${cliphist} list | ${wofi} -S dmenu) && echo "$selected" | ${cliphist} decode | wl-copy''
              ]
          )
      )
      ++
      # Change workspace
      (map (n: "SUPER,${n},workspace,name:${n}") workspaces)
      ++
      # Move window to workspace
      (map (n: "SUPERSHIFT,${n},movetoworkspacesilent,name:${n}") workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList (key: direction: "SUPER,${key},exec, ${hyprFocus}/bin/vim-hypr-nav ${direction}") directions)
      ++
      # Move windows
      (lib.mapAttrsToList (
          key: direction: "SUPERSHIFT,${key},movewindoworgroup,${direction}"
        )
        directions)
      ++
      # Open next window in given direction
      (lib.mapAttrsToList (
          key: direction: "SUPERCONTROL,${key},layoutmsg,preselect ${direction}"
        )
        directions)
      ++
      # Move monitor focus
      (lib.mapAttrsToList (key: direction: "SUPERALT,${key},focusmonitor,${direction}") directions)
      ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (
          key: direction: "SUPERALTSHIFT,${key},movecurrentworkspacetomonitor,${direction}"
        )
        directions);

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
      "SUPER SHIFT, mouse:272, resizewindow"
    ];
  };
}
