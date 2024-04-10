{lib, config,  pkgs, ... }: 
{
	config = lib.mkIf config.homelab.enable {
		services.jellyfin = {
			enable = true;
			openFirewall = true;
			user = "juicy"; #TODO setup proper permissions for "jellyfin" user
		};
	
		environment.systemPackages = with pkgs; [
			jellyfin
			jellyfin-web
			jellyfin-ffmpeg
		];
	};	
}
