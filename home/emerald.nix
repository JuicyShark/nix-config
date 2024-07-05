{ pkgs, ... }:

{
  imports = [
    ./common
    ./common/theme.nix
  	./programs
  ];



  # TODO Merge into firefox file, only enable for Jake
  #programs.firefox.enableGnomeExtensions = true;
  programs.gnome-shell.enable = true;

  home.packages = with pkgs; [
      armcord      #protonplus       Delete if only wanting latest GE Proton
      gnome.gnome-characters
      gnome.gnome-shell-extensions
  ];
	home.username = "jake";
	home.homeDirectory = "/home/jake";
	home.stateVersion = "24.05";
}
