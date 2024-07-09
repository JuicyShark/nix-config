{config, osConfig, lib, pkgs, ... }:
{

  imports = [
    #./zsh
    ./nvim
    ./yazi.nix
    ./git.nix
    ./bottom.nix
    ./eza.nix
    ./fastfetch.nix
    ./starship.nix
    ./direnv.nix
    ./git.nix
    ./gpg.nix
  ];

  config = {

    programs.nushell = {
      enable = true;
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake ${config.xdg.userDirs.documents}/nixos-config#'${pkgs.hostname}/bin/hostname -s' --log-format internal-json -v |& sudo ${pkgs.nix-output-monitor}/bin/nom --json";
        test = "sudo nixos-rebuild test --flake ${config.xdg.userDirs.documents}/nixos-config#'${pkgs.hostname}/bin/hostname -s ' --log-format internal-json -v |& sudo ${pkgs.nix-output-monitor}/bin/nom --json";
        ff = "$EDITOR $(${pkgs.fzf}/bin/fzf --preview '${pkgs.bat}/bin/bat {}')";
        rebuildclean = "sudo nixos-rebuild switch --flake ${config.xdg.userDirs.documents}/nixos-config#'${pkgs.hostname}/bin/hostname -s' --upgrade --log-format internal-json -v |& sudo ${pkgs.nix-output-monitor}/bin/nom --json && nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo nix-store --optimise";
        upgrade = "sudo nix flake update ${config.xdg.userDirs.documents}/nixos-config && nixos-rebuild switch --flake ${config.xdg.userDirs.documents}/nixos-config --log-format internal-json -v |& sudo ${pkgs.nix-output-monitor}/bin/nom --json";
        cd = "z";
        ls = "${pkgs.eza}/bin/eza --group-directories-first -a --colour=always --icons=always";
        tree = "${pkgs.eza}/bin/eza --tree --icons=always --colour=always";
        cat = "${pkgs.bat}/bin/bat";
        btop = "${pkgs.bottom}/bin/btm";
        nixconfig = "nvim ${config.xdg.userDirs.documents}/nixos-config";
        notes = "nvim -c 'Neorg index'";
        journal = "nvim -c 'Neorg journal today'";
        grep = "${pkgs.ripgrep}/bin/rg";
        dante = "ssh ${osConfig.main-user}@192.168.54.60 -p 2033";
        jake = "ssh ${osConfig.main-user}@192.168.54.59 -p 2033";
        juicy = "ssh ${osConfig.main-user}@192.168.54.54 -p 2033";
        hermes = "ssh ${osConfig.main-user}@192.168.54.56 -p 2033";
      };
    };


    home.packages = with pkgs; [
      #Utilities
      glfw
      speedtest-cli
      trippy # Network diagnostics
      viddy # Modern Watch command
      so #stackoverflow search
      circumflex # HackerNews in the terminal

      dig # check dns list
      rustscan
      ffsend
      gitui

      gcc       # C compiler
		  /* nix tools */
		  manix  # Nix pkg and options search


    ] ++ (if osConfig.raspberryDev.enable then [
      # Raspberry Pi
    nrfconnect
      nrf5-sdk
      #nrfutil
      nrf-command-line-tools
      rpi-imager
      rpiboot
      segger-jlink
      coreboot-toolchain.arm
      /* Raspberry Pico */
      pioasm
		  pico-sdk
		  picotool
      minicom

      # openthread Border Router
      #nrfutil
      nrf5-sdk
      nrfconnect
      nrf-command-line-tools
    ] else [

    ]);


  programs = {
    atuin = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        auto_sync = true;
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
  };


};
}
