{ pkgs, ...}:

{ 
	services.xserver.windowManager.dwm = {
		enable = true;
		package = pkgs.dwm.override {
			patches = [
				# Centered Master for UltraWide
				(pkgs.fetchpatch {
					url = "https://dwm.suckless.org/patches/centeredmaster/dwm-centeredmaster-6.1.diff";
					hash = "sha256-SRQIauM67mw04f/e1IStpGXR7/O/OTcgh+hM1rugT7A=";
				})
			];
		};
	};
	environment.systemPackages = with pkgs; [
		dmenu-rs
	];
}
