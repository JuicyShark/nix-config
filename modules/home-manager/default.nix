{ inputs, lib, config, ... }: 
{
	home.username = "juicy";
	home.homeDirectory = "/home/juicy";
	home.stateVersion = "24.05"; 
  
	programs.home-manager.enable = true;

  imports = [
  		inputs.nix-colors.homeManagerModules.default
  		./terminal
		./nvim
		./development
];
	#++ lib.optional (config.desktopEnvironment != "none") ./gui
	colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
}
