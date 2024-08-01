{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.juicy = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../hosts/leo/ssh_host_ed25519_key.pub);
    hashedPasswordFile = config.sops.secrets.juicyPassword.path;
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
    };
  };
}
