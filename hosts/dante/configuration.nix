# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

	imports = [
    ../common/shared-configuration.nix
    ../common/nvidia.nix
		./hardware-configuration.nix
  ];  
  
  config = {
	  # Enable Custom flags for Module selection
	  homelab.enable = true;
    #cybersecurity.enable = true;
	  nvidiaLegacy.enable = true;

    networking.hostName = "dante";

   /* sops.secrets.password = {
      sopsFile = ../juicy/secrets/juicy.yaml;
      neededForUsers = true;
    }; */


    users.users.${config.main-user} = {
      isNormalUser = true;
      #hashedPasswordFile = config.sops.secrets.password.path;
      shell = pkgs.zsh;
      description = config.main-user;
      extraGroups = [ "wheel" "juicy" ]
      ++ ifTheyExist [
        "network"
        "mysql"
        "media"
        "git"
        "libvirtd"
        "deluge"
        "nextcloud"
        "networkmanager"
      ];

      /* openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
      ]; */
  
  packages = [pkgs.home-manager];
  };


    home-manager.users.${config.main-user} = import ../../home/${config.networking.hostName}.nix;
  };
}
