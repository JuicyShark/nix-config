{ pkgs, inputs, config, ... }:
{
  imports = [
    inputs.hyprland.nixosModules.default
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  environment.systemPackages = with pkgs; [
    polkit_gnome
    pwvucontrol
  ];
  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = [ "/lib/qt-6/plugins" ];
  };

  programs.hyprland = {
    enable = true;
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome ${config.main-user}' --cmd Hyprland";
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

  security.pam.services.hyprlock = {};
  security.rtkit.enable = true;

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
}
