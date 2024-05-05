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
        "$mainMod SHIFT, ${ws}, hy3:movetoworkspace, ${toString (x + 1)}, follow"
				"$mainMod CTRL, ${ws}, hy3:movetoworkspace, ${toString (x +1)}"
      ]
    )
    10);
in
{
  config = lib.mkIf osConfig.desktop.enable {
    home.packages = with pkgs; [
      grim
      slurp
      imagemagick
    ];
    wayland.windowManager.hyprland.settings = {
    "$mainMod" = "ALT";
    bind = [
      "SUPER SHIFT, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"
      	"$mainMod, return, exec, ${pkgs.kitty}/bin/kitty"
		  	"$mainMod SHIFT, T, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c 'Neorg journal today"
        "$mainMod, T, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c 'Neorg index'"
		  	"$mainMod, escape, exec, [float; size 950 650; move onscreen 100%-0;] ${pkgs.kitty}/bin/kitty ${pkgs.bottom}/bin/btm"
		  	"$mainMod, period, exec, [float; size 1650 850; center;] ${pkgs.kitty}/bin/kitty ${pkgs.yazi}/bin/yazi"
		  	#"$mainMod, ?, exec, ${pkgs.kitty}/bin/kitty hyprkeys" #TODO implement keybind helper
		  	"$mainMod SHIFT, Q, hy3:killactive,"
		  	#"$mainMod, M, exit,"
		  	"$mainMod, P, togglefloating"
		  	"$mainMod SHIFT, P, pin"
		  	"$mainMod, space, exec, anyrun"
		  	"$mainMod, B, exec, ${pkgs.firefox}/bin/firefox"
        #"$mainMod SHIFT, B, exec, ${pkgs.qutebrowser}/bin/qutebrowser"
		  	"$mainMod, slash, exec, ${pkgs.kitty}/bin/kitty nvim $(${pkgs.fzf}/bin/fzf))"
		  	", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
		  	", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
		  	", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

	        "$mainMod, o, toggleopaque"

		  	# Move focus with mainMod + arrow keys
		  	"$mainMod, s, hy3:movefocus, l, visible"
		  	"$mainMod, f, hy3:movefocus, r, visible"
		  	"$mainMod, e, hy3:movefocus, u, visible"
        "$mainMod, d, hy3:movefocus, d, visible"
		  	"$mainMod, r, hy3:changefocus, raise"
        "$mainMod, w, hy3:changefocus, lower"
        "$mainMod, tab, hy3:focustab, right, wrap"
        "$mainMod, SHIFT TAB, hy3:focustab, left, wrap"

  			"$mainMod CTRL, s, hy3:makegroup, h"
  			"$mainMod CTRL, f, hy3:makegroup, h"
  			"$mainMod CTRL, e, hy3:makegroup, v"
        "$mainMod CTRL, d, hy3:makegroup, v"

        "$mainMod CTRL, a, hy3:changegroup, opposite"
			  "$mainMod, g, hy3:makegroup, tab"
			  "$mainMod SHIFT, g, hy3:changegroup, toggletab"

  			# Resize windows with mainMod + SUPER + arrow keys
	  		"$mainMod SUPER, s, resizeactive, 25 0"
		  	"$mainMod SUPER, f, resizeactive, -25 0"
			  "$mainMod SUPER, e, resizeactive, 0 -25"
			  "$mainMod SUPER, d, resizeactive, 0 25"
			  # Move windows with mainMod + shift + arrow keys
			  "$mainMod SHIFT, s, hy3:movewindow, l, once, visible"
			  "$mainMod SHIFT, f, hy3:movewindow, r, once, visible"
			  "$mainMod SHIFT, e, hy3:movewindow, u, once, visible"
			  "$mainMod SHIFT, d, hy3:movewindow, d, once, visible"

        # Buggy with hy3
        #"$mainMod, grave, togglespecialworkspace, scratchpad"
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
  };
}
