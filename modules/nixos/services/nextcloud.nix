{ lib, config, pkgs, ... }:
{
	config = lib.mkIf config.homelab.enable {
		environment.etc."nextcloud-admin-pass".text = "testing!Password9879";
		services.nextcloud = {
			enable = true;
			hostName = "localhost";
			config.adminpassFile = "/etc/nextcloud-admin-pass";
			extraApps = {
				inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
			};
			extraAppsEnable = true;
		};
	};
}
