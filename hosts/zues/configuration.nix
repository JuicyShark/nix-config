{ config, pkgs, ... }:

{
  imports = [
	  ../common/shared-configuration.nix
	  ./hardware-configuration.nix
	  ../common/hyprland.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

    # User Setup
    sops.secrets.password = {
      sopsFile = ../leo/secrets/juicy.yaml;
      neededForUsers = true;
    };

    users.users.${config.main-user} = {
      isNormalUser = true;
      #hashedPasswordFile = config.sops.secrets.password.path;
      shell = pkgs.zsh;
      description = config.main-user;
      extraGroups = [ "wheel" "juicy" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
      ];
      packages = [pkgs.home-manager];
    };

  networking.hostName = "zues";



}
