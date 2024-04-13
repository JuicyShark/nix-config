{ inputs, lib, config, ... }: 
{
  home.username = "juicy";
  home.homeDirectory = "/home/juicy";
  home.stateVersion = "24.05"; 
  
	programs.home-manager.enable = true;

  imports = [			
		./terminal
		./nvim
    ./development
    ./gui
    inputs.nix-colors.homeManagerModules.default
  ]; # ++ (lib.optionals (config.desktopEnironment != "none") [./gui]);
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
}
