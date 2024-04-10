{ inputs, ... }: 
{
  home.username = "juicy";
  home.homeDirectory = "/home/juicy";
  home.stateVersion = "24.05"; 
  nix.gc = {
		automatic = true;
		frequency = "daily";
		options = "--delete-older-than 5d";
	};
	programs.home-manager.enable = true;


  imports = [
  			
		./terminal
		./gui
		./firefox.nix
		./packages.nix
   		./themes.nix
		./nvim
		./development
	];
}
