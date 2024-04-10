{config, lib, ...}:
{ 
 config = lib.mkIf config.homelab.enable {
		services.redis = {
			enable = true; 
			databases = 2;
		};
	};
}
