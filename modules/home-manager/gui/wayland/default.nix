{config, pkgs ... }:

{
	imports =  [
		./hyprland
  ];

	home.packages = with pkgs; [
		wl-clipboard
		wl-mirror
		wlr-randr
	];
}
