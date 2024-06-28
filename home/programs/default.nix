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
    ./messaging.nix
 ];

	home.packages = with pkgs; [

    tidal-hifi  # Music
    #parrot

    bambu-studio
    #orca-slicer
    osu-lazer
	];
}
