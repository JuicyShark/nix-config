{
  pkgs,
  config,
  inputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  sops.secrets.jakePassword = {
    sopsFile = ../../hosts/secrets.yaml;
    neededForUsers = true;
  };

  users.users.jake = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.jakePassword.path;
    shell = pkgs.zsh;
    description = config.main-user;
    extraGroups =
      ["wheel" "jake"]
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
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    users.jake = {
      pkgs,
      inputs,
      ...
    }: {
      imports = [
        ../shared-home-configuration.nix
      ];
      programs = {
        gpg.enable = true;
      };
    };
  };
}
