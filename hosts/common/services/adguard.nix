{lib, config, ...}:
{
	config = lib.mkIf (config.homelab.enable) { 
		services.adguardhome = {
			enable = true; 
			openFirewall = true;
			settings.bind_port = 8008;
		};
	};
}
