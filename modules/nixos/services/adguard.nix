{lib, config, ...}:
{
	config = lib.mkIf (config.services.adguardhome.enable) {
		services.adguardhome = {
			openFirewall = true;
			port = 8008;
		};
	};
}
