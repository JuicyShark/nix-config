{
  description = "Juicy's messy WIP config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
 neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
 ags.url = "github:Aylur/ags";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };
  outputs = { self, nixos, nixpkgs, nixpkgs-stable, home-manager, hyprland, anyrun, ags, nix-colors, nixvim, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        juicy = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit self inputs system; };
          modules = [
            ./hosts/juicy/configuration.nix
          ];
        };
        emerald = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit self inputs system; };
          modules = [
            ./hosts/emerald/configuration.nix
          ];
        };
        dante = nixos.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/dante/configuration.nix
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
