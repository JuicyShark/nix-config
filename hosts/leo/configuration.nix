{ pkgs, inputs, lib, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{



  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  nix.sshServe = {
    enable = false;
    write = true;
  };

  cybersecurity.enable = true;

    environment.systemPackages = with pkgs; [
      wally-cli   # Flash zsa Keyboard
      keymapviz   # Zsa Oryx dep
      rpi-imager  # Raspberry Pi Imaging Utility
    ];

    programs = {
      hyprland.enable = true;
    };

    services.mopidy = {
      enable = true;
      extensionPackages = with pkgs; [
        mopidy-tidal
        mopidy-mpd
      ];
    };

  hardware = {
    keyboard.zsa.enable = true;
    logitech.wireless.enable = true;
  };
     # nvidia.enable = true;
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
  imports = [
    ./hardware-configuration.nix
    ../common/gaming.nix
    ../common/nvidia.nix
    ../common/shared-configuration.nix
  ];
}
