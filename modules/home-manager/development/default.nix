{pkgs, ...}:
{
	home.packages = with pkgs; [
		/* Coding stuff */
		/* LSP Language Servers */
		nil # Nix language server
		clang-tools # C language server
		gcc
		rustup

		/* nix tools */ 
		manix  # Nix pkg and options search

		/* Git */
		gh 
		lazygit # TUI for git, pretty cool but no idea how to use

		/* Raspberry Pico */
		pico-sdk
		picotool
		minicom

	];

	imports = [ 
		./git.nix
	];
}
