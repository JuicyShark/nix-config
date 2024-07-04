{ config, lib, pkgs, inputs, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  username = "juicy";
in
  {
    age.secrets.juicy-pass = {
      file = ../../../juicy/secrets/juicy-pass.age;
      mode = "770";
      owner = username;
      group = "root";
    };
    users.users.${username} = {
      isNormalUser = true;
      passwordFile = config.age.secrets.juicy-pass.path;
      shell = pkgs.zsh;
      description = username;
      extraGroups = [ "wheel" "juicy" ]
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
        "networkmanager"
      ];

      openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ./ssh.pub);
      packages = [pkgs.home-manager];
    #TODO add password for user on fist install
    #hashedPasswordFile = config.sops.secrets.juicy-password.path;
  };

    
    home-manager.users.${username} = import ../../../../home/${config.networking.hostName}.nix;

}
