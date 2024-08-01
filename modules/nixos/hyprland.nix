{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  config = lib.mkIf config.gui.enable {
    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };
      thunar.enable = true;
    };

    # GTK portal not installed properly along side hyprPortal by hyprland
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    };

    services = {
      #TODO use ags to power login with greetd
      greetd = {
        enable =
          if config.services.xserver.enable
          then false
          else true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --greeting 'Welcome ${config.main-user}' --cmd Hyprland";
            user = config.main-user;
          };
        };
      };

      pipewire = {
        enable =
          if config.services.xserver.enable
          then false
          else true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        lowLatency.enable = true;
      };
      dbus.packages = [pkgs.gcr];
      blueman.enable = true;
      upower.enable = true;
      #upower.noPollBatteries = true;
      udisks2.enable = true; # Auto Mount USB
      #power-profiles-daemon.enable = true;  # Daemon to manage power
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
    };

    security.rtkit.enable = true;
    # TODO Keychain still not passing login info on login
    security.pam.services.greetd.enableGnomeKeyring = true;
    security.pam.services.greetd.sshAgentAuth.enable = true;
    security.pam.services.greetd.gnupg.enable = true;
    security.pam.services.hyprlock = {};
    security.pam.services.hyprlock.gnupg.enable = true;
    security.pam.services.hyprlock.sshAgentAuth.enable = true;

    systemd = {
      services.greetd.serviceConfig = {
        # Without this errors will spam on screen
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        # Without these bootlogs will spam on screen
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    };
    environment = {
      variables = {
        NIXOS_OZONE_WL = "1";
        _JAVA_AWT_WM_NONEREPARENTING = "1";
        SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
        DISABLE_QT5_COMPAT = "0";
        GDK_BACKEND = "wayland,x11,*";
        ANKI_WAYLAND = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORM = "wayland";
        DISABLE_QT_COMPAT = "0";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        MOZ_ENABLE_WAYLAND = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
        XDG_CURRENT_DESKTOP = "Hyprland";
        #TODO can this run wayland and x11?
        SDL_VIDEODRIVER = "x11";
        CLUTTER_BACKEND = "wayland";
        QT_PLUGIN_PATH = "${pkgs.qt6.qtbase}/lib/qt6/plugins";
      };

      systemPackages = with pkgs; [
        pwvucontrol
        #libsForQt5.qt5.qtwayland
        qt6.qtwayland
        qt6.qtbase
        qt6.qtwayland
        qt6ct
        wsdd
      ];
    };
  };
}
