{
  description = "Juicy's messy WIP config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos.url = "nixpkgs/nixos-unstable";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    emacs-overlay.url  = "github:nix-community/emacs-overlay";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland?ref=v0.40.0";
      submodules = true;
    };
    hy3 = {
      type = "git";
      url = "https://github.com/outfoxxed/hy3?ref=hl0.40.0";
      submodules = true;
      inputs.hyprland.follows = "hyprland";
    };
    ags.url = "github:Aylur/ags";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixos, nixpkgs, nixpkgs-f2k, home-manager, hyprland, hy3, ags, anyrun, nix-colors, nixvim, sops-nix, rust-overlay, ... }@inputs:
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
