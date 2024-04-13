{ inputs, pkgs, config, ...}:
{
home.packages = with pkgs; [
	dconf
	];
	
	gtk = {
		enable = true;
  		cursorTheme.package = pkgs.catppuccin-cursors.mochaBlue;
  		cursorTheme.name = "Catppuccin-Mocha-Blue-Cursors";
  		iconTheme.package = pkgs.catppuccin-papirus-folders;
  		iconTheme.name = "cat-mocha-blue";
		theme = {
      			name = "Catppuccin-Mocha-Compact-Blue-Dark";
      			package = pkgs.catppuccin-gtk.override {
        			accents = [ "blue" ];
        			size = "compact";
        			tweaks = [ "rimless" "black" ];
        			variant = "mocha";
      			};
    		};
  	};

	# Now symlink the `~/.config/gtk-4.0/` folder declaratively:
	xdg.configFile = {
  		"gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  		"gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  		"gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
	};


	# Set Font in GTK
	xdg.configFile."gtk-3.0/settings.ini".text = ''
    		[Settings]
    		gtk-font-name=Hack Nerd Font 13
  	'';

  	xdg.configFile."gtk-4.0/settings.ini".text = ''
    		[Settings]
    		gtk-font-name=Hack Nerd Font 13
  	'';
	# Set Font in KDE
	home.file.".Xresources".text = ''
    		Xft.dpi: 96
    		Xft.antialias: true
    		Xft.hinting: true
    		Xft.rgba: rgb
    		Xft.autohint: false
    		Xft.hintstyle: hintslight
    		Xft.lcdfilter: lcddefault
    		*font: xft:Hack Nerd Font:size=13
  	'';
}
