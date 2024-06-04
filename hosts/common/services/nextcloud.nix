{ lib, config, pkgs, ... }:
{
	config = lib.mkIf config.homelab.enable {
	  services.nextcloud = {
			enable = true;
			hostName = "localhost";
			config.adminpassFile = config.sops.secrets.nextcloud-admin-pass.path;
			extraApps = {
				inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
			};
      extraAppsEnable = true;
      settings = {
        dbhost = "127.0.0.1:9050";
      };
    };
    sops.secrets.nextcloud-admin-pass = {
      owner = "nextcloud";
      group = "nextcloud";
    };
	};
}
