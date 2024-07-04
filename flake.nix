{
  description = "Juicy's messy WIP config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos.url = "nixpkgs/nixos-unstable";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    nix-gaming.url = "github:fufexan/nix-gaming";
    ags.url = "github:Aylur/ags";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    sops-nix.url = "github:Mic92/sops-nix";
    #emacs-overlay.url  = "github:nix-community/emacs-overlay";
    #nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
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
      url = "https://github.com/hyprwm/Hyprland?ref=0.40.1";
      inputs.nixpkgs.follows = "nixpkgs";
      submodules = true;
    };
    hypr-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
   /*hypr-scripts = {
     url = "github:hyprwm/contrib";
     inputs.nixpkgs.follows = "nixpkgs";
    };
    hy3 = {
      type = "git";
      url = "https://github.com/outfoxxed/hy3?ref=hl0.40";
      submodules = true;
      inputs.hyprland.follows = "hyprland";
    };*/
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    /* rust-overlay = {
      url = "github:oxalicalay";
      inputs.nixpkgs.follows = "nixpkgs";
    }; */
  };
  outputs = { self, nixos, nixpkgs, nix-gaming, home-manager, hyprland, hypr-plugins, ags, anyrun, nix-colors, nixvim, nix-software-center, sops-nix, ... }@inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      leo = nixpkgs.lib.nixosSystem {
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
        specialArgs = { inherit self inputs system; };
        modules = [
          ./hosts/dante/configuration.nix
        ];
      };
      anon = nixos.lib.nixosSystem {
        specialArgs = { inherit self inputs system; };
        modules = [
          ./hosts/anon/configuration.nix
        ];
      };
      nix-wsl = nixos.lib.nixosSystem {
        specialArgs = { inherit self inputs system; };
        modules = [
          ./hosts/nix-wsl/configuration.nix
        ];
      };
    };
  };
}
