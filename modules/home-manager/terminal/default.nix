{ inputs, pkgs, ... }: 
{
	imports = [
		./bat.nix
		./fastfetch.nix
		./kitty.nix
		./zsh.nix
	];
}
