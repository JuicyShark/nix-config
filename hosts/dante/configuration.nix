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
      gitea.enable = false;
      jellyfin.enable = false;
      nfs.server.enable = true;
      nextcloud.enable = false;
      homepage-dashboard.enable = false;

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
      matrix-synapse = {
        enable = true;
        settings = {
          server_name = "http:matrix.nixlab.au";
          public_baseurl = "https://nixlab.au";
          listeners = [
            {
              port = 8008;
              #bind_address = "::1";
              type = "http";
              tls = false;
              x_forwarded = true;
              resources = [
                {
                  names = ["client" "federation"];
                  compress = false;
                }
              ];
            }
          ];

          database = {
            name = "sqlite3";
            args = {
              database = "/var/lib/matrix-synapse/homeserver.db";
            };
          };
          #         media_store_path = "/var/lib/matrix-synapse/media";
          #         uploads_path = "/var/lib/matrix-synapse/uploads";
        };
      };

      nginx = {
        enable = false;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        virtualHosts."vaultwarden.nixlab" = {
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          };
        };
        virtualHosts."juicedHome.nixlab" = {
          enableACME = true;
          forceSSL = true;
          locations = {
            "/_matrix" = {
              proxyPass = "http://localhost:8008";
              extraConfig = ''
                proxy_set_header X-Forwarded-For $remote_addr;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header Host $host;
                client_max_body_size 50M;
              '';
            };
            "= /.well-known/matrix/server" = {
              extraConfig = ''
                add_header Content-Type application/json;
                return 200 '{"m.server": "example.com:443"}';
              '';
            };
            "= /.well-known/matrix/client" = {
              extraConfig = ''
                add_header Content-Type application/json;
                add_header Access-Control-Allow-Origin *;
                return 200 '{"m.homeserver":{"base_url":"https://example.com"},"m.identity_server":{"base_url":"https://vector.im"}}';
              '';
            };
          };
        };
      };
    };
    systemd.services.matrix-synapse.serviceConfig = {
      StateDirectory = "matrix-synapse";
      StateDirectoryMode = "0700";
    };
    security.polkit.enable = true;
    networking.hostName = "dante";
    networking.firewall.allowedTCPPorts = [80 443 8448];
  };
}
