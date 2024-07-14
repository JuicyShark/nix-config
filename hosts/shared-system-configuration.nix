{ config, inputs, pkgs, lib, ... }:
{
options = {
    cybersecurity.enable = lib.mkEnableOption "Pentesting tools";
    raspberryDev.enable = lib.mkEnableOption "Raspberry Pi Dev Packages";
    desktop.enable = lib.mkEnableOption "Desktop and programs Packages";
    homelab.enable = lib.mkEnableOption "Server Packages";
    main-user = lib.mkOption {
      type = lib.types.str;
      default = "juicy";
      description = "main user on host";
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
  };

  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.impermanence.nixosModules.impermanence
    ../modules/nixos
  ];

  config = {
    environment.defaultPackages = lib.mkForce [ ];
    nixpkgs.overlays = [
      inputs.neorg-overlay.overlays.default
    ];

    programs = {
      git.enable = true;
      dconf.enable = true;
    };
    services = {
      openssh.enable = true;
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
        iosevka-bin
        hack-font
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        (nerdfonts.override {fonts = ["Iosevka" "Hack"];})
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

    # Setup Systems secrets
    # Run in host folder:  nix-shell -p sops --run "sops secrets/secrets.yaml"
    sops = {
      secrets = {
        rootPassword = {
          sopsFile = ./secrets.yaml;
          neededForUsers = true;
        };
       #wireguardKey.neededForUsers = true;
        sshKey.neededForUsers = true;
      };

      defaultSopsFile = ./${config.networking.hostName}/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = [ "/etc/keys/ssh/ssh_host_ed25519_key" ];
      age.keyFile = "/etc/keys/age/age_host.txt";# ];
      age.generateKey = true;
    };

    # Default network setting
    networking = {
      useDHCP = lib.mkDefault false;
      hostName = lib.mkDefault "anon";
      defaultGateway = lib.mkDefault "192.168.54.99";
      nameservers = lib.mkDefault ["192.168.54.99" ];
      networkmanager.enable = lib.mkDefault false;
      wireguard.enable = false;
      firewall.allowedUDPPorts = [ 51820 ];
      wireguard.interfaces.wg0  = {
        listenPort = 51820;
        #privateKeyFile = config.sops.secrets.wireguardKey.path;
      };
    };

    users.defaultUserShell = pkgs.nushell;
    users.users.root = {
      shell = pkgs.nushell;
      isSystemUser = true;
      hashedPasswordFile = config.sops.secrets.rootPassword.path;
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

        "/etc/keys"
        "/etc/NetworkManager"
        "/etc/nix"
        { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
      ];
      files = [
       # "/etc/machine-id"
      #  { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; };}
      ];
    };

    system.stateVersion = "24.05";
  };
}
