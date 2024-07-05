{  pkgs, ... }:
let
in
{
  imports = [
    ./zsh
    ./nvim
    ./yazi.nix
    ./git.nix
  ];
  home.packages = with pkgs; [
    #Utilities
    glfw
    speedtest-cli
    trippy # Network diagnostics
    viddy # Modern Watch command
    so #stackoverflow search
    circumflex # HackerNews in the terminal

    dig # check dns list
    rustscan
    ffsend
    gitui

    gcc       # C compiler
		/* nix tools */
		manix  # Nix pkg and options search

		/* Raspberry Pico */
		pico-sdk
		picotool
		minicom
  ];
}
