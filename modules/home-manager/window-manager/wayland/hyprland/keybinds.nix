{ pkgs, ... }:
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
in 
{

  wayland.windowManager.hyprland.settings = {
  "$mainMod" = "ALT";
    bind = [
			"SUPER SHIFT, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m region --clipboard-only"
			"SUPER CTRL, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m output --clipboard-only"
			"SUPER CTRL, C, exec, ${pkgs.hyprpicker}/bin/hyprpicker"
			"$mainMod, return, exec, ${pkgs.kitty}/bin/kitty"
			"$mainMod SHIFT, T, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c 'Neorg journal today"				
      "$mainMod, T, exec, [float; center] ${pkgs.kitty}/bin/kitty nvim -c 'Neorg index'"
			"$mainMod, escape, exec, [float; size 950 650; move onscreen 100%-0;] ${pkgs.kitty}/bin/kitty btm"
			"$mainMod, period, exec, [float; size 1650 850; center;] ${pkgs.kitty}/bin/kitty yazi"
			#"$mainMod, ?, exec, ${pkgs.kitty}/bin/kitty hyprkeys" #TODO implement keybind helper
			"$mainMod SHIFT, Q, killactive,"
			#"$mainMod, M, exit,"
			"$mainMod, P, togglefloating"
			"$mainMod SHIFT, P, pin" 
			"$mainMod, space, exec, anyrun"
			"$mainMod, B, exec, ${pkgs.firefox}/bin/firefox"
			"$mainMod SHIFT, B, exec, ${pkgs.qutebrowser}/bin/qutebrowser"
			"$mainMod, slash, exec, ${pkgs.kitty}/bin/kitty ${pkgs.neovim}/bin/nvim $(${pkgs.fzf}/bin/fzf))"
			", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 10%+"
			", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 10%-"
			", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
			", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
			# Move focus with mainMod + arrow keys
			"$mainMod, s, movefocus, l"
			"$mainMod, f, movefocus, r"
			"$mainMod, e, movefocus, u"
			"$mainMod, d, movefocus, d"
			"$mainMod, w, focusurgentorlast"
			
			#Master layout
			"$mainMod, r, layoutmsg, focusmaster master"
			"$mainMod SHIFT, r, layoutmsg, swapwithmaster master"
			"$mainMod, a, layoutmsg, mfact 0.483"
			"$mainMod SHIFT, a, layoutmsg, mfact 0.675"
			"$mainMod CTRL, s, layoutmsg, orientationleft"
			"$mainMod CTRL, f, layoutmsg, orientationright"
			"$mainMod CTRL, e, layoutmsg, orientationtop"
			"$mainMod CTRL, d, layoutmsg, orientationbottom"	
			"$mainMod CTRL, a, layoutmsg, orientationcenter"

			#Dwindle layout
			"$mainMod CTRL, s, layoutmsg, preselect l"
			"$mainMod CTRL, f, layoutmsg, preselect r"
			"$mainMod CTRL, e, layoutmsg, preselect u"
			"$mainMod CTRL, d, layoutmsg, preselect d"
			"$mainMod, a, pseudo"
			"$mainMod SHIFT, a, layoutmsg, swapsplit"

			# Resize windows with mainMod + SUPER + arrow keys
			"$mainMod SUPER, s, resizeactive, 25 0"
			"$mainMod SUPER, f, resizeactive, -25 0"
			"$mainMod SUPER, e, resizeactive, 0 -25"
			"$mainMod SUPER, d, resizeactive, 0 25"
			# Move windows with mainMod + shift + arrow keys
			"$mainMod SHIFT, s, movewindoworgroup, l"
			"$mainMod SHIFT, f, movewindoworgroup, r"
			"$mainMod SHIFT, e, movewindoworgroup, u"
			"$mainMod SHIFT, d, movewindoworgroup, d"

			"$mainMod, g, togglegroup"
			"$mainMod SHIFT, g, lockactivegroup, toggle"
			"$mainMod, tab, changegroupactive, f"
			"$mainMod SHIFT, tab, changegroupactive, b"
			# Scroll through existing workspaces with mainMod + scroll
			"$mainMod, mouse_down, workspace, e+1"
			"$mainMod, mouse_up, workspace, e-1"
			# Special Workspace 
			"$mainMod, grave, togglespecialworkspace, scratchpad"
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
}
