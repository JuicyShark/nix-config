{ lib, config, inputs, pkgs, ... }:
{
	imports = [ 
		inputs.home-manager.nixosModules.home-manager
		inputs.sops-nix.nixosModules.sops
		../modules/nixos
  ];

	environment.systemPackages = with pkgs; [ sops ];
  
  programs = {
    zsh.enable = true;
    neovim.enable = true;
    neovim.defaultEditor = true;
  };

	sops = {
	  defaultSopsFile = ./secrets/secrets.yaml;
	  defaultSopsFormat = "yaml";
  	age.keyFile = "/home/juicy/.config/sops/age/keys.txt";
  };
  
  nix = { 
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 5d";
		};
		optimise = {
			automatic = true;
			dates = ["daily"];
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  console = {
		earlySetup = true;
		font = "${pkgs.terminus_font}/share/consolefonts/ter-i32b.psf.gz";
		packages = with pkgs; [ terminus_font ];
	};

	time.timeZone = "Australia/Brisbane";
	i18n.defaultLocale = "en_AU.UTF-8";

  users = {
    defaultUserShell = pkgs.zsh;
    users.juicy = {
		  isNormalUser = true;
		  description = "Juicy";
		  extraGroups = [ "networkmanager" "wheel" ];
    };
  };
  
    home-manager =  {
    	  extraSpecialArgs = { inherit inputs; };
    		users = {
      	  juicy = import ../modules/home-manager/default.nix;
    		};
      };
  networking.networkmanager.enable = true; 
  nixpkgs.config.allowUnfree = true;

	fonts.packages = with pkgs; [
	  hack-font
		(nerdfonts.override { fonts = ["Hack"]; })
  ];
  
  system.stateVersion = "24.05";
}
