{ pkgs, ... }:

{
  imports = [
    ./common
    ./programs
  ];


  # Jakey needs access to a normal editor
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc-icons
      catppuccin.catppuccin-vsc
      vscodevim.vim
    ];
  };
  programs.gnome-shell.enable = true;

  home.packages = with pkgs; [
      ranger
      obsidian
      discord
      gnome.gnome-characters
      gnome.gnome-shell-extensions
  ];
	home.username = "jake";
	home.homeDirectory = "/home/jake";
	home.stateVersion = "24.05";
}
