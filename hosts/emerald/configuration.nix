{ pkgs, config, inputs, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

in
{
  imports = [
    ../common/shared-configuration.nix           # Global options between machines
    ../common/nvidia.nix                  # Nvidia compatibilty
    ../common/gaming.nix                  # Add Steam
    ../common/printer.nix                 # will i ever print?
    ../common/hyprland.nix                # The Dark Side Calls
    ./hardware-configuration.nix          # Options specifc to pc hardware unique to you only
    inputs.nix-software-center.packages.${pkgs.system}.nix-software-center # Graphical software installer for Nix
  ];

  config = {
    main-user = "jake";
    ## enable xserver and gnome desktop
    services.xserver = {
      enable = false;
      displayManager.gdm.enable = false;
      desktopManager.gnome.enable = false;
    };

    security = {
      pam = {
        services.gdm.enableGnomeKeyring = true;
        loginLimits = [
          { domain = "@users"; item = "rtprio"; type = "-"; value = 1; } #allow apps to request realtime priority
        ];
      };
    };

    services = {
      gvfs.enable = true;                   # required; gnome virtual file system
      udisks2.enable = true;                # optional; auto mounts usb filesystems
      sysprof.enable = true;                # optional; monitor system
      blueman.enable = true;                # optional; gui for managing bluetooth devices

      udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  networking.hostname = "emerald";
  networking.networkmanager.enable = true;

    users.users.${config.main-user} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = config.main-user;
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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMsJd6JmEQtQ1er5vuTA3Frz2JBcgndpPcQlhjK7xcY"
      ];
    };
  };
}
