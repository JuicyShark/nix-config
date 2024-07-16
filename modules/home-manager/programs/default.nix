{pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./obs.nix
	#./neo4j.nix
    #./cyberSec-packages.nix
    #./qutebrowser
    ./music.nix
    ./messaging.nix
    ./kitty.nix
    ./foot.nix
  ];
	home.packages = with pkgs; [
		zed-editor	
		rustc
		rustycli
		zig
	];
}
