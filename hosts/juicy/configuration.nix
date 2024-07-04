{ pkgs, inputs, lib, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

  imports = [
    inputs.hyprland.nixosModules.default
    ../common/shared-configuration.nix
    ../common/nvidia.nix
    ../common/gaming.nix
    ../common/printer.nix
    ./hardware-configuration.nix
  ];


    cybersecurity.enable = true;

    nixpkgs.overlays = [
      inputs.neorg-overlay.overlays.default
    ];

    environment.systemPackages = with pkgs; [
      wally-cli   # Flash zsa Keyboard
      keymapviz   # Zsa Oryx dep
      polkit_gnome
    ];

    #programs / WM's to ensure downloaded on system
    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };

    };
    systemd = {
      user.services.polkit-gnome-autentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];

        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
       };
      };
    };
    # GTK portal not installed properly by hyprland
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };


    # Services should be installed via Nix Config to work
    services = {

      #TODO use ags to power login with greetd
      greetd = {
	  	  enable = true; # login manager
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome Juicy' --cmd Hyprland";
            user = "juicy";
          };
        };
      };

      #TODO use server to distribute music
      mopidy = {
        enable = true;
        extensionPackages = with pkgs; [
          mopidy-tidal
          mopidy-mpd
        ];
      };
      gnome.gnome-keyring.enable = true;
      udisks2.enable = true;
      power-profiles-daemon.enable = true;
      gvfs.enable = true;
    };


    security = {
      polkit.enable = true;
      pam.services.hyprlock = {};
      pam.loginLimits = [
        { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
      ];
    };


    hardware = {
      keyboard.zsa.enable = true;
      logitech.wireless.enable = true;
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

     /* openssh.authorizedKeys.keyFiles = [
        ./secrets/id_ed25519.pub
        ./secrets/ssh_host_ed25519_key.pub
        ./secrets/ssh_host_rsa_key.pub
      ]; */
      packages = [pkgs.home-manager];
  };


    home-manager.users.${config.main-user} = import ../../home/${config.networking.hostName}.nix;

}
