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

    nixpkgs.overlays = [
      inputs.neorg-overlay.overlays.default
    ];

    environment.systemPackages = with pkgs; [
      wally-cli
      keymapviz
      xdg-desktop-portal-gtk
    ];

  networking.hostName = "juicy";

  #programs / WM's to ensure downloaded on system
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    gamescope = {
      enable = true;
    };
    river.enable = false;

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
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-tidal
      mopidy-mpd
    ];
    configuration = ''
      [audio_output]
      type = "pipewire"
      name = "PipeWire Sound Server"
      [mpd]
      enabled = true
      hostname = ::
      port = 6600
      max_connections = 30
      connection_timeout = 720
      [http]
      enabled = true
      port = 5809
      [file]
      enabled = true
      [tidal]
      enabled = true
      quality = LOSSLESS
      playlist_cache_refresh_secs = 0
      #lazy = false
      #login_method = AUTO
#      auth_method = PKCE
     # login_server_port = 5889
      client_id = 2jVGCyHcBLfzfzmE
      client_secret = GMtHAEeRBptasCVz2enAtoQxQ82mTyyiJ7bXN7HXKBE=
     # [tidal]
     # quality = LOSSLESS
     # playlist_cache_refresh_secs = 5000
     # login_method = AUTO
     # auth_method = PKCE
     # login_server_port = 5889
      '';
    };

    services = {
      xserver = {
        enable = true;
        libinput = {
          enable = true;
          mouse = {
            accelProfile = "flat";
          };
        };
        xrandrHeads = [
          "DP-1"
          {
            primary = true;

          }
          "HDMI-A-1"
          {
            primary = false;
          }
        ];
      };
    # Printing
    printing = {
      enable = true;
      openFirewall = true;
      defaultShared = true;
    };
    # ags dep
    greetd = {
	  	enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome Juicy' --cmd Hyprland";
          user = "juicy";
        };
      };
    };
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
    blueman.enable = false;
  };

  security.pam.services.hyprlock = {};
  security.pam.loginLimits = [
    { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  ];
  hardware = {
    bluetooth.enable = true;
    keyboard.zsa.enable = true;
    logitech.wireless.enable = true;
    #xone.enable = true;
    steam-hardware.enable = true;
    xpadneo.enable = true;
  };
};
}
