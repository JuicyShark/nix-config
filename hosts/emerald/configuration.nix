{pkgs, ...}: {
  imports = [
    ../../home-manager/users/jake/jake.nix
    ../shared-system-configuration.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/gaming.nix
    ./hardware-configuration.nix
  ];

  config = {
    main-user = "jake";

    security.pam.services.gdm.enableGnomeKeyring = true;
    security.pam.loginLimits = [
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];

    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [thunar-volman];
      };
    };

    services = {
      sysprof.enable = true;
      blueman.enable = true;
      udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    };
  };
}
