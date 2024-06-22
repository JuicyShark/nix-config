{pkgs, ... }:

{

  imports = [
    ./firefox.nix
    ./obs.nix
    ./themes.nix
    #./neo4j.nix
    #./cyberSec-packages.nix
    ./qutebrowser
    ./music.nix
    #./emacs.nix
 ];

	home.packages = with pkgs; [

		/* Miscellaneous */
    signal-desktop #Messages
    telegram-desktop

    tidal-hifi  # Music

    discord
    #discordo
    #parrot

    bambu-studio
    #orca-slicer
    osu-lazer
	];
}
