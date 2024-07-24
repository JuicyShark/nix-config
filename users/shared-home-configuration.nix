{
  inputs,
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    #inputs.impermanence.nixosModules.home-manager.impermanence
    ../modules/home-manager
  ];
  # Match font options from nix config
  options = {
    font = lib.mkOption {
      default = osConfig.font;
      type = lib.types.str;
      description = "Font to use.";
    };
    scaling = lib.mkOption {
      default = osConfig.scaling;
      type = lib.types.float;
      description = "Scaling; Higher on higher res and lower on lower res";
    };
  };

  config = {
    programs.home-manager.enable = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/documents";
      videos = "${config.home.homeDirectory}/videos";
      pictures = "${config.home.homeDirectory}/pictures";
      music = "${config.home.homeDirectory}/music";
      desktop = "${config.home.homeDirectory}/.local/desktop";
      download = "${config.home.homeDirectory}/tmp";
      templates = "${config.xdg.userDirs.documents}/templates";
      publicShare = "${config.xdg.userDirs.documents}/share";

      /*
         config = {
        backgrounds = "${config.xdg.userDirs.pictures}/backgrounds";
        screenshots = "${config.xdg.userDirs.pictures}/screenshots";
        notes = "${config.xdg.userDirs.documents}/notes";
      };
      */
    };

    home = {
      username = lib.mkDefault "juicy";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "24.05";
      sessionPath = ["$HOME/.local/bin"];
      sessionVariables = {
        FLAKE = "${config.xdg.userDirs.documents}/nixos-config";
      };
    };

    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  };
}
