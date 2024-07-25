{config, ...}: {
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
      mutableSettings = true;
    };
  };

  networking = {
    useDHCP = false;
    enableIPv6 = true;
    nameservers = ["192.168.54.99" "8.8.8.8"];
    wireless.enable = false;
    networkmanager.enable = false;
    wlanInterfaces.wlan.device = "enp1s0";

    firewall = {
      enable = true;
      trustedInterfaces = ["enp2s0" "wg0" "enp3s0" "enp4s0"];

      extraCommands = ''
        iptables -A FORWARD -i wg0 -j ACCEPT
        iptables -A FORWARD -o wg0 -j ACCEPT
      '';
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
    /*
      settings = {
      interfaces = [ "enp2s0" "enp4s0" ];
      listenAddress = [ "::1" "192.168.54.99" "192.168.68.99" ];
      server = "8.8.8.8";
      name_servers = "::1 127.0.0.1";

    };
    */
    extraConfig = ''
      domain-needed
      bogus-priv
      filterwin2k
      expand-hosts
      domain=lan
      local=/lan/
      enable-ra
      localise-queries
      except-interface=enp1s0
      dhcp-range=::,constructor:enp1s0,ra-stateless,ra-names
      dhcp-range=192.168.54.100,192.168.54.200,12h
      dhcp-range=192.168.68.100,192.168.68.200,12h
      dhcp-lease-max=100
      dhcp-option=option:router,192.168.54.99
      dhcp-authoritative

      address=/vaultwarden.homelab/192.168.54.60
      address=/jellyfin.homelab/192.168.54.60
      address=/homepage.homelab/192.168.54.60
      address=/gitea.homelab/192.168.54.60

    '';
  };
}
