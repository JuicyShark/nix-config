{ pkgs, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

  sops.secrets.jakePassword = {
    sopsFile = ../../../secrets/secrets.yaml;
    neededForUsers = true;
  };

  users.users.jake = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.jakePassword.path;
    shell = pkgs.nushell;
    description = config.main-user;
    extraGroups = [ "wheel" "jake" ]
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
  };
}
