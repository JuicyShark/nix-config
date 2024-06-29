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
    ../common/gaming.nix
    ../common/printer.nix
    ./hardware-configuration.nix
  ];

  config = {
    cybersecurity.enable = true;

    nixpkgs.overlays = [
      inputs.neorg-overlay.overlays.default
    ];

    environment.systemPackages = with pkgs; [
      wally-cli   # Flash zsa Keyboard
      keymapviz   # Zsa Oryx dep
    ];
  
    #programs / WM's to ensure downloaded on system
    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
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

      udisks2.enable = true;
      power-profiles-daemon.enable = true;
      gvfs.enable = true;
    };

    security.pam.services.hyprlock = {};
    security.pam.sshAgentAuth.enable = true;
    security.pam.loginLimits = [
      { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    ];
    
    hardware = {
      keyboard.zsa.enable = true;
      logitech.wireless.enable = true;
    };

    networking.hostName = "leo";
  };
}
