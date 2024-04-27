{lib, config, pkgs, ...}:
{	
	config = lib.mkIf config.homelab.enable {
		users.groups.media = { }; 
		users.users.juicy.extraGroups = [ "media" ]; 
		
		systemd.tmpfiles.rules = [
      "d /media 0770 - media - -"
      "d /media/movies 0770 - media - -"
      "d /media/tv-shows 0770 - media - -"
      "d /media/youtube 0770 - media - -"
      "d /media/songs 0770 - media - -"
      "d /media/tmp 0770 - media - -"
		];
    environment.systemPackages = with pkgs; [
      # dim
     ];

		services = {
			
			jellyfin = {
				enable = true;
				user = "juicy";
				group = "media";
				openFirewall = true;
      };

      /*jellyseer = {
        enable = true;
        openFirewall = true; 
        port = 8097;
      };*/
			
			deluge = {
				enable = true;
        #declarative = true;
				user = "deluge";
				group = "deluge";
				openFirewall = true;
        #authFile = config.sops.secrets.deluge-secrets.path;
				config = {
					download_location = "/media/tmp";
					max_upload_speed = "500.0";
					share_ratio_limit = "1.5";
					allow_remote = true;
					daemon_port = 58846;
					listen_ports = [6881 6889];
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
        owner = "deluge";
        group = "deluge";
      };
    };
	};
}
