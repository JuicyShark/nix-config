{
  description = "NixOS configuration";

  inputs = {
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	  nixos.url = "nixpkgs/nixos-unstable";
	  home-manager = {
	  	url = "github:nix-community/home-manager";
	  	inputs.nixpkgs.follows = "nixpkgs";
	  };
	  hyprland.url = "github:hyprwm/Hyprland";
	  anyrun.url = "github:Kirottu/anyrun";
  	anyrun.inputs.nixpkgs.follows = "nixpkgs";
		nix-colors.url = "github:misterio77/nix-colors";
		nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
		sops-nix.url = "github:Mic92/sops-nix";
  };
  outputs = { self, nixos, nixpkgs, home-manager, hyprland, anyrun, nix-colors, nixvim, sops-nix, ... }@inputs:
  let
    system = "x86_64-linux";
	in {
		nixosConfigurations = {
      juicy = nixpkgs.lib.nixosSystem {
      	specialArgs = { inherit inputs system; };
				 modules = [
           ./hosts/juicy/configuration.nix
			  ];
		  };
			dante = nixos.lib.nixosSystem {
      	specialArgs = { inherit inputs system; };
        modules = [
          ({config, lib, desktopEnvironment, ...}: {
            imports = [
              ./hosts/dante/configuration.nix
            ];
          })
				];
      };
      anon = nixos.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [
          ./hosts/anon/configuration.nix
        ];
      };
      nix-wsl = nixos.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [
          ./hosts/nix-wsl/configuration.nix
        ];
      };
	  };
	};
}
