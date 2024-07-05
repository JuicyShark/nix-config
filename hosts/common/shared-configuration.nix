{ config, inputs, pkgs, lib, ... }:
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    #./common/monitor.nix
    ./services
  ];

  options = {
    main-user = lib.mkOption {
      type = lib.types.str;
      default = "juicy";
    };

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

/*    hardware.display = {
  monitors = lib.mkOption {
    type = lib.types.listOf (lib.types.attrsOf {
      name = lib.types.str;
      alias = lib.types.str;
      width = lib.types.int;
      height = lib.types.int;
      refreshRate = lib.types.int;
      primary = lib.types.bool;
      headless = lib.types.bool;
    });
    description = "List of monitor configurations.";
    default = [];
  };
}; */

  };


  config = {
    environment.defaultPackages = lib.mkForce [ ];

    nixpkgs.overlays = [
      inputs.neorg-overlay.overlays.default
    ];

    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      useGlobalPkgs = true;
      users.${config.main-user} = import ../../home/${config.networking.hostName}.nix;
    };

    programs = {
      zsh.enable = true;
      git.enable = true;
      dconf.enable = true;
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
        substituters = ["https://nix-gaming.cachix.org"];
        trusted-users = ["nix-ssh" "juicy" "jake" ];
        trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
      };
    };

    time.timeZone = "Australia/Brisbane";
    i18n.defaultLocale = "en_AU.UTF-8";

    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = true;
    };

    security.polkit.enable = true;
    security.pam.loginLimits = [
        { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
      ];
    hardware.enableRedistributableFirmware = true;

    # Installed Fonts
    fonts = {
      packages = with pkgs; [
        material-icons
        material-design-icons
        roboto
        dejavu_fonts
        iosevka-bin
        hack-font
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        jetbrains-mono
        (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono" "Hack"];})
      ];
      enableDefaultPackages = false;
      # this fixes emoji stuff
      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        defaultFonts = {
          monospace = [
            "Iosevka Term"
            "Iosevka Term Nerd Font Complete Mono"
            "Iosevka Nerd Font"
            "Noto Color Emoji"
            "Hack Nerd Font"
          ];
          sansSerif = ["Noto Sans" "Noto Color Emoji"];
          serif = ["Noto Serif" "Noto Color Emoji"];
          emoji = ["Noto Color Emoji"];
        };
      };
    };

    system.stateVersion = "24.05";
  };
}
