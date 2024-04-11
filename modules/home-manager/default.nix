{ ... }: 
{
  home.username = "juicy";
  home.homeDirectory = "/home/juicy";
  home.stateVersion = "24.05"; 
  
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
