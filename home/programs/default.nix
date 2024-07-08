{pkgs, ... }:

{

  imports = [
    ./firefox.nix
    ./obs.nix
    #./neo4j.nix
    #./cyberSec-packages.nix
    #./qutebrowser
    ./music.nix
    #./emacs.nix
    ./messaging.nix
    ./kitty.nix
 ];

	home.packages = with pkgs; [

	];
}
