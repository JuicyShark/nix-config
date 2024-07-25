{pkgs, ...}: {
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
      };

      nginx = {
        enable = true;
        virtualHosts = {
          "vaultwarden.homelab" = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:8000";
            };
          };
          "jellyfin.homelab" = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:8096";
            };
          };
          "pirateslife.homelab" = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:9050";
            };
          };
          "homepage.homelab" = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:8562";
            };
          };
          "gitea.homelab" = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:8199";
            };
          };
          "nextcloud.homelab" = {
            locations."/" = {
              proxyPass = "http://127.0.0.1:9060";
            };
          };
        };
      };
    };

    security.polkit.enable = true;
    networking.hostName = "dante";
  };
}
