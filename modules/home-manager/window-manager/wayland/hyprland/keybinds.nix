{ pkgs, lib, osConfig, ... }:
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

     vimHyprNav = import ../../../cli/nvim/plugins/vim-hypr-nav.nix {
    inherit (pkgs) stdenv fetchFromGitHub installShellFiles;
  };
in
{
  config = lib.mkIf osConfig.desktop.enable {
    home.packages = [
      pkgs.hyprshot
      pkgs.kitty
      vimHyprNav
    ];
    wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bind = [
		  	# Move focus with mainMod + arrow keys
		  	"$mainMod, left, exec, ${vimHyprNav}/bin/vim-hypr-nav l"
		  	"$mainMod, right, exec, ${vimHyprNav}/bin/vim-hypr-nav r"
		  	"$mainMod, up, exec, ${vimHyprNav}/bin/vim-hypr-nav u"
        "$mainMod, down, exec, ${vimHyprNav}/bin/vim-hypr-nav d"

        "$mainMod, next, changegroupactive, f"
        "$mainMod, prior, changegroupactive, b"

        # Move windows with mainMod + shift + arrow keys
			  "$mainMod SHIFT, left, movewindow, l"
			  "$mainMod SHIFT, right, movewindow, r"
			  "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # Open next Window in given direction
  			"$mainMod CTRL, left, layoutmsg, preselect l"
  			"$mainMod CTRL, right, layoutmsg, preselect r"
  			"$mainMod CTRL, up, layoutmsg, preselec u"
        "$mainMod CTRL, down, layoutmsg, preselect d"

  			# Resize windows with mainMod + SUPER + arrow keys
	  		"$mainMod ALT SHIFT, left, resizeactive, 75 0"
		  	"$mainMod ALT SHIFT, right, resizeactive, -75 0"
			  "$mainMod ALT SHIFT, up, resizeactive, 0 -75"
	  	  "$mainMod ALT SHIFT, down, resizeactive, 75"

        # layout / window management
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod SHIFT, A, layoutmsg, swap"
        "$mainMod SHIFT, G, togglegroup"
        "$mainMod SHIFT, L, lockactivegroup, toggle"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod SHIFT, T, settiled"
		  	"$mainMod SHIFT, P, pin"
        "$mainMod SHIFT, O, toggleopaque"

        # Quick launch
        "$mainMod CTRL, return, exec, ${pkgs.kitty}/bin/kitty"
		  	"$mainMod CTRL, space, exec, anyrun"
		  	"$mainMod CTRL, J, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c 'Neorg journal today"
        "$mainMod CTRL, N, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c 'Neorg index'"
		  	"$mainMod CTRL, escape, exec, [float; size 950 650; move onscreen 100%-0;] ${pkgs.kitty}/bin/kitty ${pkgs.bottom}/bin/btm"
	      "$mainMod CTRL, F, exec, [float; size 1650 850; center;] ${pkgs.kitty}/bin/kitty ${pkgs.yazi}/bin/yazi"
		  	"$mainMod CTRL, W, exec, ${pkgs.firefox}/bin/firefox"
        "$mainMod CTRL, Q, exec, [group new;] ${pkgs.qutebrowser}/bin/qutebrowser --target window www.google.com"
        "$mainMod CTRL, slash, exec, ${pkgs.kitty}/bin/kitty nvim $(${pkgs.fzf}/bin/fzf))"

        # Utility
        "$mainMod SHIFT, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"

        # Media
		  	", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
		  	", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
		  	", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"


         # Buggy with hy3
        "$mainMod, grave, togglespecialworkspace, special:scratchpad"
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
  };
}
