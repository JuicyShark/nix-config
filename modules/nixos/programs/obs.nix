{ lib, config, pkgs, ...}:
{
	config = lib.mkIf config.gaming.enable {
		environment.systemPackages = with pkgs; [
			obs-studio
			obs-cli
			#obs-studio-plugins.wlrobs
			#obs-studio-plugins.vaapi
			#obs-studio-plugins.nvfbc
		];
	};
}
