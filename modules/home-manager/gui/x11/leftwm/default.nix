{pkgs, home, ...}:
{
	home.packages = with pkgs; [
		leftwm
		dmenu-rs
		feh
		polybar
	];
	imports = [
		./leftwm.nix
	];
}
