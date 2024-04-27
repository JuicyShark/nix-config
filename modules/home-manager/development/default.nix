{pkgs, ...}:
{
	home.packages = with pkgs; [
		/* Coding stuff */
		gcc # C Compiler
    rustc
    cargo
    rustfmt

		/* nix tools */ 
		manix  # Nix pkg and options search
		 
		/* Raspberry Pico */
		pico-sdk
		picotool
		minicom

	];

	imports = [ 
		./git.nix
	];
}
