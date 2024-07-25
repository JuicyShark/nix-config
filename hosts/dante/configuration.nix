{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../users/juicy/juicy.nix
    #../../home-manager/users/jake/jake.nix
    ../../modules/nixos/nvidia.nix
    ../shared-system-configuration.nix
    ./hardware-configuration.nix
  ];

  config = {
    nvidiaLegacy.enable = true;
    desktop.enable = false;

    services = {
      openssh.enable = true;
      gitea.enable = true;
      jellyfin.enable = true;
      nfs.server.enable = true;
      nextcloud.enable = false;
      homepage-dashboard.enable = true;

      mopidy = {
        enable = true;
        extensionPackages = with pkgs; [
          mopidy-tidal
          mopidy-mpd
        ];
      };

      # TODO setup nginx
      vaultwarden = {
        enable = true;
        config = {
          DOMAIN = "http://vaultwarden.nixlab";
          SIGNUPS_ALLOWED = true;

          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = "8521";

          WEB_VAULT_ENABLED = true;
        };
      };

      nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        virtualHosts."vaultwarden.nixlab" = {
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          };
        };
      };
    };

    security.polkit.enable = true;
    networking.hostName = "dante";
    networking.domain = "nixlab";
  };
}
