{ lib, pkgs, inputs, config, ... }:
{

  imports = [
    inputs.hyprland.nixosModules.default
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  config = lib.mkIf config.programs.hyprland.enable {
  environment.systemPackages = with pkgs; [
    polkit_gnome
    pwvucontrol
  ];
  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = [ "/lib/qt-6/plugins" ];
  };

  programs.hyprland = {
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
# GTK portal not installed properly by hyprland
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  services = {
  #TODO use ags to power login with greetd
    greetd = {
	    enable = (if config.services.xserver.enable then false else true); # login manager
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --greeting 'Welcome ${config.main-user}' --cmd Hyprland";
          user = config.main-user;
        };
      };
    };

    pipewire = {
      enable = (if config.services.xserver.enable then false else true);
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      lowLatency.enable = true;
    };

    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
  };

    security.rtkit.enable = true;

    security.pam.services.greetd.gnome-keyring.enable = true;
    security.pam.services.greetd.sshAgentAuth.enable = true;
    security.pam.services.greetd.gnupg.enable = true;
    security.pam.services.greetd.enable = true;

    security.pam.services.hyprlock = {};
    security.pam.services.hyprlock.gnupg.enable = true;
    security.pam.services.hyprlock.sshAgentAuth.enable = true;
    security.pam.services.hyprlock.gnome-keyring.enable = true;


  systemd = {
    services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
  };
}
