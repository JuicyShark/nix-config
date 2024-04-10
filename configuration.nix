{ inputs, pkgs, lib, ... }:
let
	steam-session = "${pkgs.xorg.xinit}/bin/startx /home/juicy/.xinitrc";
	hyprland-session = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions/hyprland.desktop";
in
{
	imports = [ 
		inputs.home-manager.nixosModules.home-manager
		inputs.sops-nix.nixosModules.sops
		./modules/nixos
	];
	environment.systemPackages = with pkgs; [
		sops
	];

	programs.zsh.enable = true;
 	users.defaultUserShell = pkgs.zsh;
	programs.neovim.enable = true;
	programs.neovim.defaultEditor = true;
		
	sops.defaultSopsFile = ./secrets/secrets.yaml;
	sops.defaultSopsFormat = "yaml";
	sops.age.keyFile = "/home/juicy/.config/sops/age/keys.txt";
	
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
	};
  	console = {
		earlySetup = true;
		font = "${pkgs.terminus_font}/share/consolefonts/ter-i32b.psf.gz";
		packages = with pkgs; [ terminus_font ];
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	time.timeZone = "Australia/Brisbane";
	i18n.defaultLocale = "en_AU.UTF-8";

	users.users.juicy = {
		isNormalUser = true;
		description = "Juicy";
		extraGroups = [ "networkmanager" "wheel" "media" ];
	};
	home-manager = {
    		extraSpecialArgs = { inherit inputs; };
    		users = {
      			juicy = import ./modules/home-manager/default.nix;
    		};
  	};

  networking.networkmanager.enable = true; 
  nixpkgs.config.allowUnfree = true;


	services.pipewire = { 
		enable = true; 
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
	fonts.packages = with pkgs; [
		hack-font
		(nerdfonts.override { fonts = ["Hack"]; })
  	];
  
	services.xserver.displayManager.lightdm.enable = true; 
	

  system.stateVersion = "24.05";
}
