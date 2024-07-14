{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    tidal-hifi
  ];
  services.mopidy = {
    enable = true;
    settings = {
      audio_output = {
        type = "pipewire";
        name = "PipeWire Sound Server";
      };
      mpd = {
        enabled = true;
        hostname = "::";
        port = 6600;
        max_connections = 30;
        connection_timeout = 720;
      };
      http = {
        enabled = true;
        port = 5809;
      };
      file = {
        enabled = true;
      };
      tidal = {
        enabled = true;
        quality = "LOSSLESS";
        playlist_cache_refresh_secs = 0;
        #lazy = false
        #login_method = AUTO
#       auth_method = PKCE
        # login_server_port = 5889
        # TODO add tidal secrets depending on user
        client_id = "2jVGCyHcBLfzfzmE";
        #client_secret = ;
      };
    };
  };

  programs.ncmpcpp = {
    enable = true;
    settings = {
      mpd_host = "::";
      mpd_port = "6600";
    };
  };
}

