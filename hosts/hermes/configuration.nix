# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
	imports = [
    ../common/shared-configuration.nix

  ];

  environment.systemPackages = with pkgs; [  bluez bluez-tools ];

  hardware = {
    bluetooth.enable = true;
      raspberry-pi = {
        config = {
          all = {
            base-dt-params = {
              krnbt = {
                enable = true;
                value = "on";
              };
            };
          };
        };
      };
    };
    security.polkit.enable = true;
    networking = {
      hostName = "hermes";
      #networkmanager.enable = true;
      interfaces = { wlan0.useDHCP = true; };
    };

    sops.secrets.password = {
      sopsFile = ../leo/secrets/juicy.yaml;
      neededForUsers = true;
    };
    users.users.root.initialPassword = "root";
    users.users.${config.main-user} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.password.path;
      shell = pkgs.zsh;
      description = config.main-user;
      extraGroups = [ "wheel" ]
     ++ ifTheyExist [
        "network"
        "mysql"
        "media"
        "git"
        "libvirtd"
        "networkmanager"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYz1y5xwfb+fRix3pbGJzqJGwBJVgNjv5bHS2owvtYP"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
      ];

  packages = [pkgs.home-manager];
  };

    users.extraUsers."jake" = {
      isNormalUser = true;
      #hashedPasswordFile = config.sops.secrets.password.path;
      shell = pkgs.zsh;
      description = "jake";
      extraGroups = [ "wheel" ]
      ++ ifTheyExist [
        "network"
        "mysql"
        "media"
        "git"
        "libvirtd"
        "networkmanager"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMsJd6JmEQtQ1er5vuTA3Frz2JBcgndpPcQlhjK7xcY"
      ];
    };
}
