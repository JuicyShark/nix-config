{ config, pkgs, ... }:
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
	  nvidiaLegacy.enable = true;

    services.mopidy = {
      enable = true;
      extensionPackages = with pkgs; [
        mopidy-tidal
        mopidy-mpd
      ];
    };
    security.polkit.enable = true;
    users.users.${config.main-user} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.password.path;
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
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I" ];
    };

    users.extraUsers."jake" = {
      isNormalUser = true;
      #hashedPasswordFile = config.sops.secrets.password.path;
      shell = pkgs.zsh;
      description = "jake";
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
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMsJd6JmEQtQ1er5vuTA3Frz2JBcgndpPcQlhjK7xcY" ];
    };

    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  programs.fuse.userAllowOther = true;
  };
}
