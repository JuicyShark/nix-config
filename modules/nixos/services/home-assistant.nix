{
  lib,
  config,
  pkgs,
  ...
}: {
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    configWritable = true;

    config = {
      http = {
        server_port = 8123;
        server_host = "127.0.0.1";
      };

      homeassistant = {
        #unit_system = "metric";
        #time_zone = config.time.timeZone;
        #temperature_unit = "C";
      };
    };
    extraComponents = [
      "default_config"
      "shopping_list"
      "esphome"
      "homeassistant_sky_connect"
      "jellyfin"
      "mpd"
      "nanoleaf"
    ];
    customComponents = with pkgs.home-assistant-custom-components; [
      gpio
      ntfy
      localtuya
    ];
  };
  services.nginx."homeassist.nixlab.au" = {
    locations."/" = {
      proxyPass = "http://${toString config.services.home-assistant.config.http.server_host}:${toString config.services.home-assistant.config.http.server_port}";
    };
  };
}
