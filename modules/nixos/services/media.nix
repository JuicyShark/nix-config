{pkgs, lib, config, ...}:
{
	config = lib.mkIf config.homelab.enable {
	users.users.media = { 
	isSystemUser = true;
	group = "media";
	};

    	users.groups.media = { };

		systemd.tmpfiles.rules = [
      "d /srv/media 0770 media media"
      "d /srv/media/downloading 0770 media media"
      "d /torrent 0770 media media"
    ];

		services = {
			jellyfin = {
				enable = true;
				group = "media";
				openFirewall = true;
      };

			deluge = {
				enable = true;
        declarative = true;
	openFirewall = false;
	group = "media";
	authFile = pkgs.writeTextFile {
        	name = "deluge-auth";
        	text = "localclient:password:10";
        };
        config = {
          copy_torrent_file = true;
          move_completed = true;
	  group = "media";
	  torrentfiles_location = "/torrent/files";
          download_location = "/torrent/downloading";
          move_completed_path = "/torrent/completed";
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
	  enabled_plugins = [ "Label" ];

	};
		web = {
			enable = true;
			port = 9050;
				openFirewall = true;
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
    sops.secrets = {
      deluge-secrets ={
        owner =  config.users.users.deluge.name;
        group =  config.users.users.deluge.group;
        mode = "0600";
      };
    };
	};
}
