{ inputs, config, osConfig, pkgs, lib, ... }:
{


  imports = [
    inputs.nix-colors.homeManagerModules.default
    #inputs.sops-nix.homeManagerModules.sops
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../../home-manager
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
    home.packages = with pkgs; [
      #sops
    ];
    programs.home-manager.enable = true;

    /*sops = {
      age.sshKeyPaths = ["/persist/home/${config.main-user}/.keys/ssh/id_ed25519"];
      age.keyFile = "/persist${config.home.homeDirectory}/.keys/age/age.txt";
      age.generateKey = true;
      defaultSopsFile = ../users/${config.home.username}/secrets.yaml;
    };*/

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/documents";
      videos =  "${config.home.homeDirectory}/videos";
      pictures =  "${config.home.homeDirectory}/pictures";
      music =  "${config.home.homeDirectory}/music";
      desktop = "${config.home.homeDirectory}/.local/desktop";
      download = "${config.home.homeDirectory}/tmp";
      templates = "${config.xdg.userDirs.documents}/templates";
      publicShare =  "${config.xdg.userDirs.documents}/share";

      /* config = {
        backgrounds = "${config.xdg.userDirs.pictures}/backgrounds";
        screenshots = "${config.xdg.userDirs.pictures}/screenshots";
        notes = "${config.xdg.userDirs.documents}/notes";
      }; */
    };

    home = {
      username = lib.mkDefault "juicy";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "24.05";
      sessionPath = [ "$HOME/.local/bin" ];
      sessionVariables = {
        FLAKE = "${config.xdg.userDirs.documents}/nixos-config";
      };

    persistence = {
      "/persist${config.home.homeDirectory}" = {
        #defaultDirectoryMethod = "symlink";
        directories = [
          "documents"
          "pictures"
          "videos"
          "music"
          ".keys"
          ".keys/age"
          ".keys/ssh"
          ".keys/gnupg"
          "tmp"
          ".local/bin"
          ".local/share/nix" # trusted settings and repl history
        ];
        allowOther = true;
      };
    };
  };


    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  };
}
