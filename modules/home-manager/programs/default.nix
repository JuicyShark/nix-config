{pkgs, ... }:


{
  imports = [
    ./firefox.nix
    ./obs.nix
	#./neo4j.nix
    #./cyberSec-packages.nix
    ./qutebrowser
    ./music.nix
    ./messaging.nix
    #./kitty.nix replaced with more minimal foot
    ./foot.nix
  ];
	home.packages = with pkgs; [
		rustc
		rustycli
		zig
	];
}
