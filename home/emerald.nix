{ ... }:

{
  imports = [
    ./common        # Global Home-Manager options
  	./programs          
  ];

  
  
  # TODO Merge into firefox file, only enable for Jake
  programs.firefox.enableGnomeExtensions = true;
  programs.gnome-shell.enable = true;

  gtk.iconTheme = {
    name = "Adwaita Dark";
    package = pkgs.gnome.gnome-adwaita-icon-theme
  };

  home.packages = with pkgs; [
      armcord      #protonplus       Delete if only wanting latest GE Proton                          
      gnome.gnome-characters
      gnome.gnome-shell-extensions 
  ];
	home.username = "jake";
	home.homeDirectory = "/home/jake";
	home.stateVersion = "24.05";
}
