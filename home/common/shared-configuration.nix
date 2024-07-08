{ inputs, config, osConfig, lib, ... }:
{


  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
  	../cli
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
        FLAKE = "$HOME/documents/nixos-config";
      };
    };

    sops = {
      age.sshKeyPaths = "${config.home.homeDirectory}/.keys/ssh/id_ed25519";
      defaultSopsFile = ../../hosts/${osConfig.networking.hostName}/secrets.yaml;
    };

    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  };
}
