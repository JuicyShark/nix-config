{ config, lib, pkgs, inputs, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  username = "jake";
in
  {
    users.users.${username} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = username;
      extraGroups = [ "wheel" ]
      ++ ifTheyExist [
        "minecraft"
        "network"
        "wireshark"
        "mysql"
        "media"
        "git"
        "libvirtd"
        "deluge"
        "nextcloud"
      ];

      openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ./ssh.pub);
      packages = [pkgs.home-manager];
    #TODO add password for user on fist install
    #hashedPasswordFile = config.sops.secrets.juicy-password.path;
  };


    home-manager.users.${username} = import ../../../../home/${config.networking.hostName}.nix;


  /* sops = {
    defaultSopsFile = ../../../secrets.yaml;
    age.keyFile = "/home/${config.users.users.juicy.name}/.config/sops/age/keys.txt";
  }; */
}
