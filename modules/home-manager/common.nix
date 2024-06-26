{ inputs, config, ... }:
{
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

  imports = [
  	inputs.nix-colors.homeManagerModules.default
  	./cli
	  ./programs
    ./development
    ./window-manager/wayland
	];
	colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
}
