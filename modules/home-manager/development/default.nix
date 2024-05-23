{pkgs, ...}:
{
	home.packages = with pkgs; [
		/* Coding stuff */
		gcc # C Compiler
    rustc
    cargo
    rustfmt
    python3

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
