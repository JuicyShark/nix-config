{ pkgs, config, ...}:
{
  home.sessionVariables.GTK_THEME = config.gtk.theme.name;
  home.packages = with pkgs; [
    #dconf
  ];

  /*dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };*/

  gtk = {
    enable = true;

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintmedium";
      gtk-xft-rgba = "rgb";
    };
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;

      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintmedium";
      gtk-xft-rgba = "rgb";
    };
    font = {
      name = config.font;
      size = 15;
    };

		theme = {
    	name = "Catppuccin-Mocha-Compact-Blue-Dark";
    	package = pkgs.catppuccin-gtk.override {
      	accents = [ "blue" ];
      	size = "compact";
      	tweaks = [ ];
      	variant = "mocha";
  	  };
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Blue-Cursors";
      size = 32;
      package = pkgs.catppuccin-cursors.mochaBlue;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };

  };
 # home.pointerCursor = {
  # gtk.enable = true;
  # package = pkgs.catppuccin-cursors.mochaBlue;
  # name = "Catppuccin-Mocha-Blue-Cursors";
  #};

	# Now symlink the `~/.config/gtk-4.0/` folder declaratively:
	xdg.configFile = {
  "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
	};

}
