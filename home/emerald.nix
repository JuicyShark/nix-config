{ pkgs, ... }:

{
  imports = [
    ./common
    ./programs
  ];

  # TODO Merge into firefox file, only enable for Jake
  #programs.firefox.enableGnomeExtensions = true;
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
      obsidian
      discord
      gnome.gnome-characters
      gnome.gnome-shell-extensions
  ];
	home.username = "jake";
	home.homeDirectory = "/home/jake";
	home.stateVersion = "24.05";
}
