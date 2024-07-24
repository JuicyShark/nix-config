{
  pkgs,
  config,
  inputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  /*
    sops.secrets.juicyPassword = {
    sopsFile = ../../hosts/secrets.yaml;
    neededForUsers = true;
  };
  */

  users.users.juicy = {
    isNormalUser = true;
    #	password = "test";
    # hashedPasswordFile = config.sops.secrets.juicyPassword.path;
    shell = pkgs.zsh;
    description = config.main-user;
    extraGroups =
      ["wheel" "juicy"]
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
    users.juicy = {
      pkgs,
      inputs,
      ...
    }: {
      # Import files specific to Juicy User Config
      imports = [
        ../shared-home-configuration.nix
      ];
      programs = {
        gpg.enable = true;
      };
    };
  };
}