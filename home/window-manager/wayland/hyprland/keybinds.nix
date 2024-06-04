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
      "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}, follow"
			"$mainMod CTRL, ${ws}, movetoworkspace, ${toString (x +1)}"
    ]
  )
  10);

  vimHyprNav = import ../../../cli/nvim/plugins/vim-hypr-nav.nix {
    inherit (pkgs) stdenv fetchFromGitHub installShellFiles;
  };
in
{
    home.packages = [
      pkgs.hyprshot
      pkgs.kitty
      vimHyprNav
    ];
    wayland.windowManager.hyprland.settings = {
      "$mainMod" = "SUPER";
      "$meh" = "ALT SHIFT CTRL";
      "$hyper" = "ALT SHIFT CTRl SUPER";
      bind = [
		  	# Move focus with mainMod + arrow keys
		  	"$mainMod, left, hy3:movefocus, l, visible"
		  	"$mainMod, right, hy3:movefocus, r, visible"
		  	"$mainMod, up, hy3:movefocus, u, visible"
        "$mainMod, down, hy3:movefocus, d, visible"
		  	"$mainMod, P, hy3:changefocus, raise"
        "$mainMod, W, hy3:changefocus, lower"
        "$mainMod, tab, hy3:focustab, right, wrap"
        "$mainMod SHIFT, TAB, hy3:focustab, left, wrap"

        # Move windows with mainMod + shift + arrow keys
			  "$mainMod SHIFT, left, hy3:movewindow, l, once, visible"
			  "$mainMod SHIFT, right, hy3:movewindow, r, once, visible"
			  "$mainMod SHIFT, up, hy3:movewindow, u, once, visible"
        "$mainMod SHIFT, down, hy3:movewindow, d, once, visible"

        # Open next Window in given direction
  			"$mainMod CTRL, left, hy3:makegroup, h"
  			"$mainMod CTRL, right,  hy3:makegroup, h"
  			"$mainMod CTRL, up,  hy3:makegroup, v"
        "$mainMod CTRL, down, hy3:makegroup, v"
        "$mainMod CTRL, G, hy3:makegroup, tab"

  			# Resize windows with mainMod + SUPER + arrow keys
	  		"$mainMod ALT SHIFT, left, resizeactive, 75 0"
		  	"$mainMod ALT SHIFT, right, resizeactive, -75 0"
			  "$mainMod ALT SHIFT, up, resizeactive, 0 -75"
	  	  "$mainMod ALT SHIFT, down, resizeactive, 0 75"

        # layout / window management
        "$mainMod SHIFT, Q, hy3:killactive,"
        "$mainMod SHIFT, A, hy3:changegroup, opposite"
        "$mainMod SHIFT, G, hy3:changegroup, toggletab"

        "$mainMod SHIFT, L, lockactivegroup, toggle"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod SHIFT, T, settiled"
		  	"$mainMod SHIFT, P, pin"
        "$mainMod SHIFT, O, toggleopaque"

        # Quick launch
        "$meh, return, exec, ${pkgs.kitty}/bin/kitty"
        "$meh, T, exec, ${pkgs.kitty}/bin/kitty"
        "$meh, space, exec, anyrun"
        "$meh, O, exec, anyrun"
		  	"$meh, J, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c 'Neorg journal today"
        "$meh, N, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c 'Neorg index'"
        "$meh, E, exec, ${pkgs.kitty}/bin/kitty emacs -nw"
		  	"$meh, escape, exec, [float; size 950 650; move onscreen 100%-0;] ${pkgs.kitty}/bin/kitty ${pkgs.bottom}/bin/btm"
	      "$meh, F, exec, [float; size 1650 850; center;] ${pkgs.kitty}/bin/kitty ${pkgs.yazi}/bin/yazi"
		  	"$meh, W, exec, ${pkgs.firefox}/bin/firefox"
        "$meh, Q, exec, [group new;] ${pkgs.qutebrowser}/bin/qutebrowser --target window www.google.com"
        "$meh, slash, exec, ${pkgs.kitty}/bin/kitty nvim $(${pkgs.fzf}/bin/fzf))"

        # Utility
        "$mainMod, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"

        # Media
		  	", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
		  	", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
		  	", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"


        # Buggy with hy3
        #"$mainMod, grave, togglespecialworkspace, special:scratchpad"
        #"$mainMod Shift, grave, movetoworkspace, special:scratchpad"
		  ]
		  ++ workspaces;

		  # Move/resize windows with mainMod + LMB/RMB and dragging
		  bindm = [
		  	"$mainMod, mouse:272, movewindow"
		  	"$mainMod, mouse:273, resizewindow"
		  	"$mainMod SHIFT, mouse:272, resizewindow"
      ];
    };
}
