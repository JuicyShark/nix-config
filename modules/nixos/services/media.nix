{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.services.jellyfin.enable {
    users.users.media = {
      isSystemUser = true;
      group = "media";
    };

    users.groups.media = {};

    environment.systemPackages = with pkgs; [
      jellyfin-ffmpeg
    ];

    systemd.tmpfiles.rules = [
      "d /persist/chonk/media 0770 - media"
      "d /persist/chonk/torrent 0770 - media"
    ];

    systemd.tmpfiles.settings = {
      "jellyfin" = {
        "/var/lib/jellyfin" = {
          d = {
            group = "media";
            mode = "0775";
            user = "jellyfin";
          };
        };
        "/srv" = {
          d = {
            group = "media";
            mode = "0775";
            user = "root";
          };
        };
      };
      "deluge" = {
        "/var/lib/deluge" = {
          d = {
            group = "media";
            mode = "0775";
            user = "deluge";
          };
        };
      };
    };

    services = {
      jellyfin = {
        group = "media";
        openFirewall = true;
      };
      nginx.virtualHosts."jellyfin.homelab" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
        };
      };
      #TODO non declarative setup due to sops not currently working
      deluge = {
        enable = true;
        declarative = true;
        openFirewall = true;
        group = "media";
        authFile = config.sops.secrets.deluge.path;
        config = {
          copy_torrent_file = true;
          move_completed = true;
          group = "media";
          torrentfiles_location = "/persist/chonk/torrent/files";
          download_location = "/persist/chonk/torrent";
          move_completed_path = "/persist/chonk/torrent";
          dont_count_slow_torrents = true;
          max_active_seeding = 6;
          max_active_limit = 12;
          max_active_downloading = 3;
          max_connections_global = 250;
          max_upload_speed = 500;
          max_download_speed = 2000;
          share_ratio_limit = 2;
          allow_remote = true;
          daemon_port = 58846;
          random_port = false;
          listen_ports = [6881 6889];
          outgoing_interface = "enp3s0";
          enabled_plugins = ["Label"];
        };

        web = {
          enable = true;
          port = 9050;
          openFirewall = true;
        };
      };
      nginx.virtualHosts."pirateslife.homelab" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:9050";
        };
      };
      prowlarr = {
        enable = true;
        openFirewall = true;
      };

      sonarr = {
        enable = true;
        group = "media";
        openFirewall = true;
      };

      bazarr = {
        enable = true;
        group = "media";
        openFirewall = true;
      };
      radarr = {
        enable = true;
        group = "media";
        openFirewall = true;
      };
      jackett = {
        enable = true;
        group = "media";
        openFirewall = true;
      };
    };

    sops.secrets.deluge = {
      group = config.users.users.deluge.group;
    };
  };
}
