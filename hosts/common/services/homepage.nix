{ lib, config, ... }:
# Jellyfin Web: 8096
# JellySeer: 8097
{ 
  config = lib.mkIf config.homelab.enable {
  services.homepage-dashboard = {
    enable = true; 
    listenPort = 8562;
    openFirewall = true;

    settings = {
      title = "Juiced Up Cult";
      theme = "dark";
      
    };

    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
      {
        search = {
          provider = "google";
        };
      }
      {
        jellyfin = {
          url = "http://localhost:8096";
          key = "";
          enableBlocks = true;
          enableNowPlaying = true;
        };
      }
      {
        jellyseer = {
          url = "http://localhost:8097";
          key = "";
        };
      }
      {
        gitea = {
          url = "http://localhost:8099";
          key = "";
        };
      }
      {
        nextcloud = {
          url = "http://localhost:9050";
        };
      }
    ];

    bookmarks = [
      
    ];
  };
};
}
