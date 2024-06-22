{ inputs, config, lib, ... }:
{
  options = {
    font = lib.mkOption {
      default = "Hack Nerd Font";
      type = lib.types.str;
      description = "Font to use.";
    };
    scaling = lib.mkOption {
      default = 1.2;
      type = lib.types.float;
      description = "Scaling; Higher on higher res and lower on lower res";
    };
  };

  imports = [
    inputs.nix-colors.homeManagerModules.default
  	./cli
	];

  config = {
	  programs.home-manager.enable = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/documents";
      desktop = "${config.home.homeDirectory}/.local/desktop";
      download = "${config.home.homeDirectory}/tmp";
      templates = "${config.xdg.userDirs.documents}/templates";
      publicShare =  "${config.xdg.userDirs.documents}/share";
      videos =  "${config.xdg.userDirs.documents}/videos";
      pictures =  "${config.xdg.userDirs.documents}/pictures";
      music =  "${config.xdg.userDirs.documents}/music";
    };

    home = {
      username = lib.mkDefault "juicy";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "24.05";
      sessionPath = [ "$HOME/.local/bin" ];
      sessionVariables = {
        FLAKE = "$HOME/nixos";
      };
    };

    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  };
}
