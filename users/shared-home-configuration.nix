{
  inputs,
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: {
  imports = [
    #inputs.impermanence.nixosModules.home-manager.impermanence
    ../modules/home-manager
  ];

  programs.home-manager.enable = true;

  stylix = {
    targets = {
      firefox.profileNames = ["default"];
      kitty.variant256Colors = true;
      nixvim.transparent_bg.main = osConfig.stylix.targets.nixvim.transparent_bg.main;
      nixvim.transparent_bg.sign_column = osConfig.stylix.targets.nixvim.transparent_bg.sign_column;

    };
  };
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/documents";
    videos = "${config.home.homeDirectory}/videos";
    pictures = "${config.home.homeDirectory}/pictures";
    music = "${config.home.homeDirectory}/music";
    desktop = "${config.home.homeDirectory}/.local/desktop";
    download = "${config.home.homeDirectory}/tmp";
    templates = "${config.xdg.userDirs.documents}/templates";
    publicShare = "${config.xdg.userDirs.documents}/public";
    extraConfig = {
      XDG_BACKGROUNDS_DIR = "${config.xdg.userDirs.pictures}/backgrounds";
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
      XDG_NOTES_DIR = "${config.xdg.userDirs.documents}/notes";
      XDG_PROJECTS_DIR = "${config.home.homeDirectory}/projects";
    };
  };
  home = {
    username = lib.mkDefault "juicy";
    # language = lib.mkDefault "English";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    preferXdgDirectories = true;
    stateVersion = lib.mkDefault "24.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = lib.mkDefault "${config.xdg.userDirs.documents}/nixos-config";
      EDITOR = lib.mkDefault "nvim";
      VISUAL = lib.mkDefault "nvim";
    };

    shellAliases = {
      rebuild = "sudo nix build switch --flake ${config.xdg.userDirs.documents}/nixos-config#$(${pkgs.hostname}/bin/hostname -s)";
      test = "sudo nix build test --flake ${config.xdg.userDirs.documents}/nixos-config#$(${pkgs.hostname}/bin/hostname -s ) --show-trace";
      rebuildclean = "sudo nix build switch --flake ${config.xdg.userDirs.documents}/nixos-config#$(${pkgs.hostname}/bin/hostname -s) --upgrade && nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo nix-store --optimise";
      upgrade = "sudo nix flake update ${config.xdg.userDirs.documents}/nixos-config && nixos-rebuild switch --flake ${config.xdg.userDirs.documents}/nixos-config --show-trace";
      cd = "z";
      ls = "${pkgs.eza}/bin/eza";
      lst = "${pkgs.eza}/bin/eza -T";

      cat = "${pkgs.bat}/bin/bat";
      btop = "${pkgs.bottom}/bin/btm";
      notes = "nvim -c 'Neorg index'";
      journal = "nvim -c 'Neorg journal today'";
      grep = "${pkgs.ripgrep}/bin/rg";

      # SSH Other Nix Machines
      dante = "ssh ${osConfig.main-user}@192.168.54.60 -p 2033";
      jake = "ssh ${osConfig.main-user}@192.168.54.59 -p 2033";
      juicy = "ssh ${osConfig.main-user}@192.168.54.54 -p 2033";
      hermes = "ssh ${osConfig.main-user}@192.168.54.56 -p 2033";
      zues = "ssh ${osConfig.main-user}@192.168.54.99 -p 2033";
    };
  };
}
