{lib, config, pkgs, ...}:
{	
	config = lib.mkIf config.homelab.enable {
		users.groups.media = { }; 
		users.users.juicy.extraGroups = [ "media" ]; 
		
		systemd.tmpfiles.rules = [
			"d /torrents 0770 - media - -"
		];
#		systemd.services.deluge = {
#			after = [ "network.target" ];
#			wantedBy = [ "multi-user.target" ];
#			script = ''
#				${pkgs.sops}/bin/sops --decrypt /home/juicy/nixos/secrets/deluge-auth.sops > /var/lib/deluge/.config/deluge/auth
#				chown deluge:media /var/lib/deluge/.config/deluge/auth
#				exec ${pkgs.deluge}/bin/deluged --config /var/lib/deluge/.config/deluge
#			'';
#
#			serviceConfig = {
#				User = "deluge";
#				Group = "media";
#			};
#
#		};

		services = {
			
			jellyfin = {
				enable = true;
				user = "juicy";
				group = "media";
				openFirewall = true;
			};
			
			deluge = {
				enable = true;
				declarative = false;
				user = "deluge";
				group = "media";
				openFirewall = true;
				#authFile = pkgs.writeText "deluge-auth" (builtins.readFile config.sops.secrets.deluge-auth);
				config = {
					download_location = "/torrents";
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
	
	};
}
