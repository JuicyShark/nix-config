{ config, inputs, pkgs, lib, ... }: {
  
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./common/services
  ];

  options = {
    font = lib.mkOption {
      default = "Hack Nerd Font";
      type = lib.types.str;
      description = "Font to use.";
    };
    scaling = lib.mkOption {
      default = 1.2;
      type = lib.types.float;
      description = "Scaling; Higher on higher res and lower on lower res";
    };
  };


  config = {
    environment.defaultPackages = lib.mkForce [ ];

    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      useGlobalPkgs = true;
    };

    programs = {
      zsh.enable = true;
      git.enable = true;
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
          serif = [ config.font ];
          emoji = [ "Hack Nerd Font" ];
          sansSerif = [ "Hack Nerd Font Propo" ];
          monospace = [ "Hack Nerd Font Mono" ];
        };
      };
      packages = with pkgs; [
        hack-font
        material-icons
        (nerdfonts.override { fonts = [ "Hack" ]; })
      ];
    };

    system.stateVersion = "24.05";
  };
}
