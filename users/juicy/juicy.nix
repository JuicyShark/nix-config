{ pkgs, config, inputs, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  sops.secrets.password = {
    sopsFile = ./secrets/secrets.yaml;
    neededForUsers = true;
  };

  users.users.juicy = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.password.path;
    shell = pkgs.nushell;
    description = config.main-user;
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
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;

    users.juicy = { pkgs, inputs, ... }:  {
      # Import files specific to Juicy User Config
      imports = [
        ../shared-home-configuration.nix
      ];

      # Daemon to manage secret (private) keys independently from any protocol
      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
        enableZshIntegration = true;
        pinentryPackage = pkgs.pinentry-gtk2;
      };
    };
  };
}
