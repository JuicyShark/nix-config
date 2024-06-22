{pkgs, ...}:
{
  home.packages = with pkgs; [
    gcc       # C compiler
 #   rust-bin.stable.latest.default # Rust Staple Toolchain


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
