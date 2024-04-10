{lib, ...}:

{
	options.displayManager = {
		type = lib.types.enum ["wayland" "x11"];
		default = "wayland";
		description = "Choose between Wayland and X11 as the Primary Display Manager";
	};
}
