{
  config,
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: let
  theme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in {
  options = {
    # toggle extra configs to be included
    raspberryDev.enable = lib.mkEnableOption "Raspberry Pi Dev Packages";
    homelab.enable = lib.mkEnableOption "Server Packages specifically for homelab configs";
    # Options to define desktop experiences
    gui = {
      enable = lib.mkEnableOption "Enable Gui apps";
      keybaordFocus.enable = lib.mkEnableOption "Keyboard centric workflow";
      cybersecurity.enable = lib.mkEnableOption "install a suite of Pentesting tools";
      gamingPC.enable = lib.mkEnableOption "install Steam";

      # TODO add x11 and nix-wsl support
      backend = lib.mkOption {
        type = lib.types.str;
        default = "wayland";
        description = "To use wayland(hyprland), x11(Gnome) or nix-wsl as a backend";
      };
    };
    # User we will assume is the main operator of the machine
    main-user = lib.mkOption {
      type = lib.types.str;
      default = "juicy";
      description = "main user on host";
    };
  };

  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.stylix.nixosModules.stylix
    ../modules/nixos
  ];

  config = {
    environment = {
      defaultPackages = lib.mkForce [];
      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        #       PAGER = "nvim -R";
        #       MANPAGER = "nvim -c 'set ft=man' -";
      };
    };
    nixpkgs.overlays = [
      inputs.neorg-overlay.overlays.default
    ];
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
        dates = ["daily"];
      };
      settings = {
        experimental-features = ["nix-command" "flakes"];
        warn-dirty = false;
        substituters = ["https://nix-gaming.cachix.org"];
        trusted-users = ["nix-ssh" "juicy" "jake"];
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
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];
    hardware.enableRedistributableFirmware = true;

    # Setup Systems secrets
    # Run in host folder:  nix-shell -p sops --run "sops secrets/secrets.yaml"

    sops = {
      # Grab main user of machines password and root pass from nix and ensure is ready on boot
      secrets.rootPassword.sopsFile = ./secrets.yaml;
      secrets.rootPassword.neededForUsers = true;
      secrets."${config.main-user}Password" = {
        sopsFile = ./secrets.yaml;
        neededForUsers = true;
      };

      # Assume we are not accessing shared sercets
      defaultSopsFile = ./${config.networking.hostName}/secrets.yaml;
      defaultSopsFormat = "yaml";
      # grab all host public keys under ./$HOST/ssh_host_ed25519_key.pub
      age.sshKeyPaths = map getKeyPath keys;
      # Why did i ever think its a good idea to stray from every default possible?
      age.keyFile = "/var/lib/sops-nix/key.txt";
      age.generateKey = true;
    };

    # Default network setting
    networking = {
      useDHCP = lib.mkDefault false;
      hostName = lib.mkDefault "anon";
      domain = lib.mkDefault "nixlab.au";
      enableIPv6 = lib.mkDefault false;
      useNetworkd = lib.mkDefault true;
      #hosts = lib.mkDefault extraHosts;
      defaultGateway.address = lib.mkDefault "192.168.54.99";
      nameservers = lib.mkDefault ["192.168.54.99"];
      networkmanager.enable = lib.mkDefault false;
      wireguard.enable = false;
      firewall.allowedUDPPorts = [51820];
      wireguard.interfaces.wg0 = {
        listenPort = 51820;
        #privateKeyFile = config.sops.secrets.wireguardKey.path;
      };
    };
    systemd.network.enable = true;
    users.defaultUserShell = pkgs.zsh;
    # Users must be setup via the config only
    users.mutableUsers = false;
    users.users.root = {
      isSystemUser = true;
      shell = config.users.defaultUserShell;
      hashedPasswordFile = config.sops.secrets.rootPassword.path;
    };

    system.stateVersion = "24.05";

    stylix = {
      enable = lib.mkDefault true;
      image = lib.mkDefault (pkgs.fetchurl {
        url = "https://www.5120x1440.com/wallpapers/329/highres/aishot-98.jpg";
        sha256 = "5ba4a998e9df625f27c1ecfe3d92296fdb503c42c027520800fa34480fe692be";
      });
      imageScalingMode = lib.mkDefault "fill";
      base16Scheme = {
        base00 = "1e1e2e"; # base
        base01 = "181825"; # mantle
        base02 = "313244"; # surface0
        base03 = "45475a"; # surface1
        base04 = "585b70"; # surface2
        base05 = "cdd6f4"; # text
        base06 = "f5e0dc"; # rosewater
        base07 = "b4befe"; # lavender
        base08 = "f38ba8"; # red
        base09 = "fab387"; # peach
        base0A = "f9e2af"; # yellow
        base0B = "a6e3a1"; # green
        base0C = "94e2d5"; # teal
        base0D = "89b4fa"; # blue
        base0E = "cba6f7"; # mauve
        base0F = "f2cdcd"; # flamingo
      };
      polarity = lib.mkDefault "dark";

      cursor = {
        name = lib.mkDefault "Afterglow-Recolored-Catppuccin-Blue";
        size = 26;
        package = lib.mkDefault pkgs.afterglow-cursors-recolored;
      };
      fonts = {
        serif = {
          package = lib.mkDefault (pkgs.nerdfonts.override {fonts = ["ZedMono"];});
          name = lib.mkDefault "ZedMono Nerd Font";
        };
        sansSerif = {
          package = lib.mkDefault (pkgs.nerdfonts.override {fonts = ["Ubuntu"];});
          name = lib.mkDefault "Ubuntu Nerd Font";
        };
        monospace = {
          package = lib.mkDefault (pkgs.nerdfonts.override {fonts = ["ZedMono"];});
          name = lib.mkDefault "ZedMono Nerd Font";
        };
        emoji = {
          package = lib.mkDefault pkgs.noto-fonts-emoji;
          name = lib.mkDefault "Noto Color Emoji";
        };
        sizes = {
          applications = lib.mkDefault 14;
          desktop = lib.mkDefault 12;
          popups = lib.mkDefault 11;
          terminal = lib.mkDefault 15;
        };
      };
      opacity = {
        applications = lib.mkDefault 0.88;
        desktop = lib.mkDefault 0.88;
        popups = lib.mkDefault 0.95;
        terminal = lib.mkDefault 0.80;
      };

      targets = {
        #      nixvim.transparent_bg.main = lib.mkDefault true;
        #      nixvim.transparent_bg.sign_column = lib.mkDefault true;
        grub.useImage = lib.mkDefault false;
      };
    };
  };
}
