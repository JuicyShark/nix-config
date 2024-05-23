{pkgs, ... }:

{

  imports = [
    ./firefox.nix
    ./obs.nix
    ./themes.nix
    ./mpv.nix
  #  ./neo4j.nix
  #  ./cyberSec-packages.nix
    ./qutebrowser.nix
 ];

	home.packages = with pkgs; [

		/* Miscellaneous */
	  nix-search-cli
		signal-desktop #Messages
		tidal-hifi  # Music
		fractal #Matrix desktop GTK client
    ventoy # USB Imager installe
    discord
    discordo
    parrot
    obsidian

	];
}
