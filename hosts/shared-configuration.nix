{ config, inputs, pkgs, lib, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    ../modules/nixos
  ];
  environment = {
    defaultPackages = lib.mkForce [ ];
    systemPackages = with pkgs; [
      sops
    ];
  };
  programs = {
    zsh.enable = true;
    git.enable = true;
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/juicy/.config/sops/age/keys.txt";

    secrets = {
      juicy-ssh = {
        owner = "juicy";
        group = "wheel";
      };
      dante-ssh = {
        owner = "juicy";
        group = "wheel";
      };
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  users = {
    defaultUserShell = pkgs.zsh;
    users.juicy = {
      isNormalUser = true;
      description = "Juicy";
      extraGroups = [ "wheel" ]
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
      ];
      openssh = {
        authorizedKeys.keys = [
          config.sops.secrets.juicy-ssh.path
          config.sops.secrets.dante-ssh.path
        ];
      };
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      juicy = import ../modules/home-manager/default.nix;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true;
  };

  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = [ "/lib/qt-6/plugins" ];
  };

  hardware.enableRedistributableFirmware = true;

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting.style = "full";
      defaultFonts = {
        serif = [ "Hack Nerd Font Propo" ];
        emoji = [ "Hack Nerd Font" ];
        sansSerif = [ "Hack Nerd Font Propo" ];
        monospace = [ "Hack Nerd Font Mono" ];
      };

    };
    packages = with pkgs; [
      hack-font
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
  system.stateVersion = "24.05";

}
