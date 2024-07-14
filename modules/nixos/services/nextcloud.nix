{ lib, config, pkgs, ... }:
{
	config = lib.mkIf config.services.nextcloud.enable {
	  services.nextcloud = {
			hostName = "localhost";
			config.adminpassFile = config.sops.secrets.nextcloud-admin.path;
			extraApps = {
				inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
			};
      extraAppsEnable = true;
      settings = {
        dbhost = "127.0.0.1:9050";
      };
    };
    sops.secrets.nextcloud-admin = {
      owner = "nextcloud";
      group = "nextcloud";
    };
	};
}