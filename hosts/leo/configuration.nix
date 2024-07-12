{ pkgs, inputs, lib, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{


    cybersecurity.enable = true;

    environment.systemPackages = with pkgs; [
      zig
      wally-cli   # Flash zsa Keyboard
      keymapviz   # Zsa Oryx dep
      rpi-imager  # Raspberry Pi Imaging

    ];

    programs = {
      hyprland.enable = true;
    };

    services = {
      mopidy = {
        enable = false;
        extensionPackages = with pkgs; [
          mopidy-tidal
          mopidy-mpd
        ];
      };
  };

  hardware = {
    keyboard.zsa.enable = true;
    bluetooth.enable = true;
    #logitech.wireless.enable = true;
  };

    users.users.${config.main-user} = {
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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
      ];
    };

  imports = [
    ./hardware-configuration.nix
    ../common/gaming.nix
    ../common/nvidia.nix
    ../common/shared-configuration.nix
  ];
}
