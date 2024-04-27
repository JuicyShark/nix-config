{lib, config, ...}:
{	
	config = lib.mkIf config.homelab.enable {
    users.groups.media = { }; 

		systemd.tmpfiles.rules = [
      "d /media 0770 - media - -"
      "d /media/movies 0770 - media - -"
      "d /media/tv-shows 0770 - media - -"
      "d /media/youtube 0770 - media - -"
      "d /media/songs 0770 - media - -"
      "d /media/tmp 0770 - media - -"
    ];

		services = {
			jellyfin = {
				enable = true;
				user = "juicy";
				group = "media";
				openFirewall = true;
      };
			
			deluge = {
				enable = true;
        declarative = true;
				user = "deluge";
				group = "deluge";
				openFirewall = true;
        authFile = config.sops.secrets.deluge-secrets.path;
        config = {
          copy_torrent_file = true;
          move_completed = true;
					torrentfiles_location = "/srv/torrents/files";
          download_location = "/srv/torrents/downloading";
          move_completed_path = "/srv/torrents/completed";
          dont_count_slow_torrents = true;
          max_active_seeding = -1;
          max_active_limit = -1;
          max_active_downloading = 8;
          max_connections_global = -1;
					max_upload_speed = "500.0";
					share_ratio_limit = "1.5";
					allow_remote = true;
          daemon_port = 58846;
          random_port = false;
					listen_ports = [6880 6880];
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
				openFirewall =  true;	
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
