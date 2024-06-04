{ pkgs, inputs, lib, ... }:

{

  options.main-user = lib.mkOption {
    type = lib.types.str;
    default = "juicy";
  };
  imports = [
    inputs.hyprland.nixosModules.default
    ../shared-configuration.nix
    ../common/users/juicy
    ../common/nvidia.nix
    ./hardware-configuration.nix
  ];
  config = {

    cybersecurity.enable = true;
    homelab.enable = false;


    nixpkgs.overlays = [
      inputs.emacs-overlay.overlay
      inputs.neorg-overlay.overlays.default
      inputs.rust-overlay.overlays.default
      inputs.nixpkgs-f2k.overlays.default
    ];

    environment.systemPackages = with pkgs; [
      wally-cli
      keymapviz
      rust-bin.stable.latest.default
      steamPackages.steamcmd
    ];

  networking.hostName = "juicy";

  #programs / WM's to ensure downloaded on system
  programs = {
    hyprland.enable = true;
    river.enable = true;
    steam = {
      enable = true;
      extest.enable = false;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    #sway.enable = true;
    openvpn3.enable = true;
  };
  services = {
    greetd = {
	  	enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome Juicy' --cmd Hyprland";
          user = "juicy";
        };
      };
    };
    blueman.enable = true;
  };
 /*   ## x11/awesome stuff
    picom.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };
 gvfs.enable = true;
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];

      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };
      displayManager.startx.enable = true;
      displayManager.session = [{ manage = "desktop";
      name = "awesomeDebug";
      start = ''
       exec ${pkgs.awesome-git}/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
      '';
    }];
    displayManager.defaultSession = "awesomeDebug";
    desktopManager.xterm.enable = false;

    windowManager.qtile = {
      enable = true;
      configFile = /home/juicy/nixos/home/window-manager/qtile;
      backend = "x11";
      extraPackages = python3Packages: with python3Packages; [
        qtile-extras
      ];
    };
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };
*/
  security.pam.loginLimits = [
    { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  ];
  hardware = {
    bluetooth.enable = true;
    keyboard.zsa.enable = true;
    logitech.wireless.enable = true;
  };
};
}
