{
  config,
  lib,
  ...
}: {
  imports = [
    ../../users/juicy/juicy.nix
    ../shared-system-configuration.nix
    ./hardware-configuration.nix
  ];

  #sops.secrets.wireguardKey.neededForUsers = true;

  services = {
    adguardhome = {
      enable = false;
      openFirewall = true;
      host = "0.0.0.0";
      mutableSettings = true;
    };
  };

  networking = {
    useDHCP = true;
    enableIPv6 = true;
    hostName = "zues";
    nameservers = ["::1" "0.0.0.0" "8.8.8.8"];
    wireless.enable = false;
    networkmanager.enable = false;
    wlanInterfaces.wlan.device = "enp1s0";

    firewall = {
      enable = true;
      trustedInterfaces = ["enp2s0" "wg0" "enp3s0" "enp4s0"];

      allowedTCPPorts = [53 80 443];
      allowedUDPPorts = [53 51820];

      /*
        extraCommands = ''
        iptables -A FORWARD -i wg0 -j ACCEPT
        iptables -A FORWARD -o wg0 -j ACCEPT
      '';
      */
    };

    nat = {
      enable = true;
      externalInterface = "enp1s0";
      internalInterfaces = ["enp2s0" "wg0" "enp3s0" "enp4s0"];
    };

    wireguard.interfaces = {
      wg0 = {
        ips = ["10.100.0.1/24"];
        listenPort = 51820;
        privateKeyFile = config.sops.secrets.wireguardKey.path;

        /*
           peers = [
          {
            # no need. tested on main home pc to tunnel to router
            publicKey = "7r2OLyMVEyHJc2ITm66fD25JD+dWKQtw9fuTisN47wg=";
            allowedIPs = [ "10.100.0.2/32" ];
          }
        ];
        */
      };
    };

    interfaces = {
      # WLAN
      enp1s0.useDHCP = true;
      # Lan for the house
      enp2s0.ipv4.addresses = [
        {
          address = "192.168.54.99";
          prefixLength = 24;
        }
      ];
      # not in use
      enp3s0.ipv4.addresses = [
        {
          address = "192.168.55.99";
          prefixLength = 24;
        }
      ];
      # AP's
      enp4s0 = {
        useDHCP = true;
        ipv4.addresses = [
          {
            address = "192.168.68.99";
            prefixLength = 24;
          }
        ];
      };
    };
  };

  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
    resolveLocalQueries = true;
    settings = {
      # General
      listen-address = ["::1" "192.168.54.99" "192.168.68.99"];
      server = ["8.8.8.8" "8.8.4.4"];
      #   domain-needed = true;
      #   bogus-priv = true;

      # Domain
      domain = "home";
      local = "/local/";
      #   enable-ra = true;
      localise-queries = true;
      /*
        interface = [
        "enp2s0"
        "enp3s0"
        "enp4s0"
      ];
      */
      except-interface = "enp1s0";
      bind-interfaces = true;
      expand-hosts = true;

      #DHCP
      /*
        dhcp-option = [
        "option:router,0.0.0.0"
        "3,0.0.0.0"
        "6,0.0.0.0"
      ];
      */

      dhcp-range = [
        "::,constructor:enp1s0,ra-stateless,ra-names"
        "::f,::ff,constructor:enp2s0"
        "::f,::ff,constructor:enp4s0"
        "192.168.54.100,192.168.54.200,12h"
        "192.168.68.100,192.168.68.200,12h"
      ];

      /*
        dhcp-host = [
        "11:22:33:44:55:66,leo,192.168.54.54"
        "11:22:33:44:55:66,emerald,192.168.54.59"
        "11:22:33:44:55:66,pi,192.168.54.56"
        "11:22:33:44:55:66,homelab,192.168.54.60"
      ];
      */

      address = [
        "/vaultwarden.home/192.168.54.60"
        "/jellyfin.home/192.168.54.60"
        "/homepage.home/192.168.54.60"
        "/gitea.home/192.168.54.60"
      ];
    };
  };
}
