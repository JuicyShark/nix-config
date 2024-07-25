{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.services.nextcloud.enable {
    services = {
      nextcloud = {
        hostName = "localhost";
        config.adminpassFile = config.sops.secrets.nextcloudAdmin.path;
        extraApps = {
          inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
        };
        extraAppsEnable = true;
        settings = {
          dbhost = "127.0.0.1:9060";
        };
      };

      nginx.virtualHosts."nextcloud.homelab" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:9060";
        };
      };
    };
    sops.secrets.nextcloudAdmin = {
      owner = "nextcloud";
      group = "nextcloud";
    };
  };
}
