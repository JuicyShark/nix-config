{ pkgs, inputs, ... }:

{

  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    inputs.nixpkgs-f2k.overlays.default
    inputs.emacs-overlay.overlay
  ];

  cyberSec.enable = true;

	imports = [
    ./hardware-configuration.nix
    ../common/users/jake
    ../common/nvidia.nix
    ../shared-configuration
  ];

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    protonplus
    vscode-with-extensions
  ];
  programs = {
    steam = {
      enable = true;
      extest.enable = false;
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      gamescopeSession = {
        enable = true;
        args = [

          #"--output-width 2560"
          #"--output-height 1440"
          "--prefer-output DP-1"
          #"--expose-wayland"
          "--steam"
        ];
      };
    };
    gamescope.enable = true;
    gamemode = {
      enable = true;
      enableRenice = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
    openvpn3.enable = true;
  };
  services = {
    blueman.enable = true;

    ## x11/awesome stuff
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
      displayManager.lightdm.enable = true;
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

 home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      jake = import ../../home/jake.nix;
    };
  };
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [

    ];
    loader = {
	    systemd-boot.enable = true;
	    efi.canTouchEfiVariables = true;
    };
  };



 ###Stutter fixes
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.variables = {
  ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
  networking.hostName = "emerald";

  # Probably better place to put these
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  hardware.xone.enable = true;


  networking = {
    useDHCP = true;
    defaultGateway = "192.168.54.99";
    nameservers = ["192.168.54.99"];
   };
}
