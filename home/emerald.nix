{ ... }:
{
  imports = [
    ./common.nix
  	./programs
    ./development
    ./window-manager/x11/awesomewm
  ];
	home.username = "jake";
	home.homeDirectory = "/home/jake";
	home.stateVersion = "24.05";
}
