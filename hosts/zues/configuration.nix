{ lib, config, pkgs, ... }:

{
  imports = [
	  ../common/shared-configuration.nix
	  ./hardware-configuration.nix
	  ../common/hyprland.nix
  ];

  sops.secrets = {
    defaultSopsFile = ./secrets/secrets.yaml;
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

    # User Setup
    sops.secrets.password = {
      sopsFile = ./secrets/secrets.yaml;
      neededForUsers = true;
    };

    users.users.${config.main-user} = {
      isNormalUser = true;
      #hashedPasswordFile = config.sops.secrets.password.path;
      shell = pkgs.zsh;
      description = config.main-user;
      extraGroups = [ "wheel" "juicy" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
      ];
      packages = [pkgs.home-manager];
    };

  networking.hostName = "zues";

  networking.firewall.allowedUDPPorts = [51820];
  networking.useNetworkd = true;
  systemd.network = {
    enable = true;
    netdevs = {
      "50-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1300";
        };
        wireguardConfig = {
          PrivateKeyFile = config.sops.secrets.wireguardKey.path;
          ListenPort = 51820;
        };
        wireguardPeers = [
          {
            PublicKey = "L4msD0mEG2ctKDtaMJW2y3cs1fT2LBRVV7iVlWZ2nZc=";
            AllowedIPs = ["10.100.0.2"];
          }
        ];
      };
    };
    networks.wg0 = {
      matchConfig.Name = "wg0";
      address = ["10.100.0.1/24"];
      networkConfig = {
        IPMasquerade = "ipv4";
        IPForward = true;
      };
    };
  };

  sops.secrets.wireguardKey = {
    sopsFile = ./secrets/juicy.yaml;
    neededForUsers = true;
  };
  networking = {
    useDHCP = lib.mkDefault false;
    nameservers = [ "8.8.8.8" ];
    firewall.enable = true;
   # defaultGateway.address = "192.168.54.99";
  #  defaultGateway.interface = "enp1s0";

    nat = {
      enable = true;
      externalInterface = "enp1s0";
      internalInterfaces = [ "enp2s0" "enp3s0" "enp4s0" ];
    };


 #  wlanInterfaces = {
 #      wlan = {
 #       device = "enp1s0";
 #      };
#  };
    interfaces = {
      enp1s0 = {


        ipv4 = {
          addresses = [{
            address = "192.168.54.98";
            prefixLength = 24;
         }];
         routes = [{
            address = "0.0.0.0";
            prefixLength = 0;
            via = "192.168.54.99";
          }];
        };
      };
      enp2s0 = {
        ipv4 = {
          addresses = [
            {
              address = "192.168.53.98";
              prefixLength = 24;
            }
          ];
          routes = [{
            address = "0.0.0.0";
            prefixLength = 0;
            via = "192.168.54.99";
          }];
        };
      };
      /*
      enp3s0 = {
        useDHCP = lib.mkDefault false;
        name = "lan1";
        ipv4 = {
          addresses = [
            {
              address = "192.168.55.91";
              prefixLength = 24;
            }
          ];
        };
      };
      enp4s0 = {
        useDHCP = lib.mkDefault false;
        name = "lan2";
        ipv4 = {
          addresses = [
            {
              address = "192.168.56.92";
              prefixLength = 24;
            }
          ];
        };
      }; */
    };
     /* nftables = {
          enable = true;
          ruleset = ''
            table ip filter {
              chain input {
                type filter hook input priority 0; policy drop;

                iifname { "enp2s0" } accept comment "Allow local network to access the router"
                iifname { "enp3s0" } accept comment "Allow local network to access the router"
                iifname { "enp4s0" } accept comment "Allow local network to access the router"
                iifname "enp1s0" ct state { established, related } accept comment "Allow established traffic"
                iifname "enp1s0" icmp type { echo-request, destination-unreachable, time-exceeded } counter accept comment "Allow select ICMP"
                iifname "enp1s0" counter drop comment "Drop all other unsolicited traffic from wan"
              }
              chain forward {
                type filter hook forward priority 0; policy drop;
                iifname { "enp2s0" } oifname { "enp1s0" } accept comment "Allow trusted LAN to WAN"
                iifname { "enp2s0" } oifname { "enp2s0" } ct state established, related accept comment "Allow established back to LANs"
               }
            }
          '';


    };*/
  };
  services.kea = {
    dhcp4.enable = true;
    dhcp4.settings = {
      interfaces-config = {
        interfaces = [
          "enp2s0"
        ];
      };


    };
  };


}
