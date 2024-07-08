{ osConfig, lib, pkgs, ... }:
{

  imports = [
    ./zsh
    ./nvim
    ./yazi.nix
    ./git.nix
  ];

  config = {

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
  };
}
