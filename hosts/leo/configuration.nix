{ pkgs, inputs, lib, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

  imports = [
    ../common/shared-configuration.nix
    ../common/nvidia.nix
    ../common/gaming.nix
    ../common/printer.nix
    ../common/hyprland.nix
    ./hardware-configuration.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  nix.sshServe = {
    enable = true;
    write = true;
  };

  cybersecurity.enable = true;

    environment.systemPackages = with pkgs; [
      wally-cli   # Flash zsa Keyboard
      keymapviz   # Zsa Oryx dep
      rpi-imager  # Raspberry Pi Imaging Utility
    ];



    services.mopidy = {
      enable = true;
      extensionPackages = with pkgs; [
        mopidy-tidal
        mopidy-mpd
      ];
    };

    networking.hostName = "leo";

    # User Setup
    sops.secrets.password = {
      sopsFile = ./secrets/juicy.yaml;
      neededForUsers = true;
    };

    users.users.${config.main-user} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.password.path;
      shell = pkgs.zsh;
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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
      ];
      packages = [pkgs.home-manager];
    };
}
