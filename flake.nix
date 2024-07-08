{
  description = "Juicy's messy WIP config";

  nixConfig = {
    trusted-users = ["nix-ssh" "juicy" "jake" ];
    extra-substituters = [
      "https://raspberry-pi-nix.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos.url = "nixpkgs/nixos-unstable";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    nix-gaming.url = "github:fufexan/nix-gaming";
    ags.url = "github:Aylur/ags";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    sops-nix.url = "github:Mic92/sops-nix";
    raspberry-pi-nix.url = "github:tstat/raspberry-pi-nix";
    impermanence.url = "github:nix-community/impermanence";
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixos, nixpkgs, nix-gaming, home-manager, hyprland, hypr-plugins, ags, nix-colors, nixvim, nix-software-center, sops-nix, raspberry-pi-nix, impermanence, disko, matugen, ... }@inputs:
  let
    system = "x86_64-linux";
    nixpkgConfig = import ./nixpkgs/config.nix;
  in
  {
    nixosConfigurations = {
      leo = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self inputs system; };
        modules = [
          ./hosts/leo/configuration.nix
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
      # FIXME get Raspberry 5 setup and acting as thread border router
      hermes = nixos.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          raspberry-pi-nix.nixosModules.raspberry-pi
          ./hosts/hermes/configuration.nix
        ];
      };

      # TODO setup a host file that reinstalls each boot.
      anon = nixos.lib.nixosSystem {
        specialArgs = { inherit self inputs system; };
        modules = [
          ./hosts/anon/configuration.nix
        ];
      };
      # TODO Setup to use Nix on Windows for Jake potentially using
      nix-wsl = nixos.lib.nixosSystem {
        specialArgs = { inherit self inputs system; };
        modules = [
          ./hosts/nix-wsl/configuration.nix
        ];
      };
    };
  };
}
