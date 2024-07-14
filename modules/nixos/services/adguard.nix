{lib, config, ...}:
{
	config = lib.mkIf (config.services.adguardhome.enable) {
		services.adguardhome = {
			openFirewall = true;
			settings.bind_port = 8008;
		};
	};
}
