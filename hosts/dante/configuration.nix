{ config, pkgs, inputs, lib, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
	imports = [
    ../common/shared-configuration.nix
    ../common/nvidia.nix
    ./hardware-configuration.nix
   # inputs.impermanence.nixosModule
  ];

  config = {
	  nvidiaLegacy.enable = true;

    programs = {

    };
    services = {
      openssh.enable = true;
    };
    hardware = {

    };
    services.mopidy = {
      enable = true;
      extensionPackages = with pkgs; [
        mopidy-tidal
        mopidy-mpd
      ];
    };
    security.polkit.enable = true;

  networking.hostName = "dante";

  fileSystems."/etc/keys" = {
      depends = ["/persist"];
      neededForBoot = true;
    };

    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/db/sudo"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"

        "/etc/NetworkManager"
        "/etc/nix"
        { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
      ];
      files = [
        "/etc/machine-id"
        {
          file = "/var/keys/secret_file"; parentDirectory = {
            mode = "u=rwx,g=,o=";
          };
        }
      ];
    };

  programs.fuse.userAllowOther = true;
  };
}
