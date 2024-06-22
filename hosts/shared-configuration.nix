{ config, inputs, pkgs, lib, ... }:
let
  #inherit (config.module.args) self;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./common/services
  ];

  environment.defaultPackages = lib.mkForce [ ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
  };

  programs = {
    zsh.enable = true;
    git.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_AU.UTF-8";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true;
  };

  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = [ "/lib/qt-6/plugins" ];
  };

  hardware.enableRedistributableFirmware = true;

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      hinting.style = "full";
      defaultFonts = {
        serif = [ "Hack Nerd Font Propo" ];
        emoji = [ "Hack Nerd Font" ];
        sansSerif = [ "Hack Nerd Font Propo" ];
        monospace = [ "Hack Nerd Font Mono" ];
      };

    };
    packages = with pkgs; [
      hack-font
      roboto
      material-icons
      icomoon-feather
      iosevka

      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
  system.stateVersion = "24.05";

}
