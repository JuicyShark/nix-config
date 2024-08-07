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
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = 3001;
      settings = {
        dns.bind_hosts = ["192.168.54.99" "192.168.68.99"];
      };
      mutableSettings = true;
    };
  };

  networking = {
    enableIPv6 = false;
    hostName = "zues";
    nameservers = ["127.0.0.1"];
    wireless.enable = false;
    networkmanager.enable = false;
    wlanInterfaces.wlan.device = "enp1s0";

    firewall = {
      enable = true;
      trustedInterfaces = ["br0"];

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
      internalInterfaces = ["br0"];
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

    bridges = {
      br0 = {
        interfaces = [
          "enp2s0"
          "enp3s0"
          "enp4s0"
        ];
      };
    };

    interfaces = {
      enp1s0.useDHCP = true;

      br0 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.54.99";
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
      listen-address = [
        "127.0.0.1"
        "192.168.54.99"
      ];
      server = ["8.8.8.8" "8.8.4.4"];
      domain-needed = true;
      bogus-priv = true;

      # Domain
      domain = "${toString config.networking.domain}";
      local = "/${toString config.networking.domain}/";
      #   enable-ra = true;
      localise-queries = true;

      #     interface = [
      #       "br0"
      #     ];

      except-interface = "enp1s0";
      #     bind-interfaces = true;
      expand-hosts = true;

      #DHCP
      dhcp-option = [
        "option:router,0.0.0.0"
        "6,0.0.0.0"
      ];

      dhcp-range = [
        "::,constructor:enp1s0,ra-stateless,ra-names"
        "192.168.54.30,192.168.54.254,5m"
      ];

      dhcp-host = [
        "11:22:33:44:55:66,leo,192.168.54.54"
        "11:22:33:44:55:66,emerald,192.168.54.59"
        "11:22:33:44:55:66,hermes,192.168.54.56"
        "11:22:33:44:55:66,dante,192.168.54.60"
      ];

      address = [
        # "/router.nixlab.au/192.168.54.98"
        #"/dante.nixlab.au/192.168.54.60"
        #"/leo.nixlab.au/192.168.54.54"
        #"/hermes.nixlab.au/192.168.54.56"
        #"/vaultwarden.nixlab.au/192.168.54.60"
        #"/jellyfin.nixlab.au/192.168.54.60"
        #"/homepage.nixlab.au/192.168.54.60"
        #"/gitea.nixlab.au/192.168.54.60"
      ];
    };
  };
}
