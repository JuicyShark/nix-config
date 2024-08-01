{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  nonTTY = lib.optionals osConfig.gui.enable [
    ./cava.nix
    ./mpv.nix
    ./bat.nix
    ./starship.nix
  ];
in {
  imports =
    [
      ./nvim
      ./yazi.nix
      ./bottom.nix
      ./fastfetch.nix
      ./developer.nix
      ./man.nix
    ]
    ++ nonTTY;

  config = {
    home.packages = with pkgs;
      [
        nix-output-monitor
        manix
        nix-index
        nix-tree

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
      ]
      ++ (
        if osConfig.raspberryDev.enable
        then [
          # Raspberry Pi
          nrfconnect
          nrf5-sdk
          #nrfutil
          nrf-command-line-tools
          rpi-imager
          rpiboot
          segger-jlink
          coreboot-toolchain.arm
          /*
          Raspberry Pico
          */
          pioasm
          pico-sdk
          picotool
          minicom

          # openthread Border Router
          #nrfutil
          nrf5-sdk
          nrfconnect
          nrf-command-line-tools
        ]
        else [
        ]
      );

    programs = {
      imv.enable = true;
      fzf = {
        enable = false;
        enableZshIntegration = true;
        defaultCommand = "fd --type file --follow --hidden --exclude .git";
        historyWidgetOptions = ["--sort" "--exact"];
        defaultOptions = [
          "--height 40%"
          "--border rounded"
          "--min-height 17"
          "--preview bat"
        ];
        /*
          colors = {
          fg = "#${config.colorScheme.palette.base0B}";
          bg = "#${config.colorScheme.palette.base00}";
          hl = "#${config.colorScheme.palette.base0E}";
          "fg+" = "#${config.colorScheme.palette.base0D}";
          "bg+" = "#${config.colorScheme.palette.base00}";
          "hl+" = "#${config.colorScheme.palette.base0D}";
          info = "#${config.colorScheme.palette.base0E}";
          prompt = "#${config.colorScheme.palette.base0F}";
          pointer = "#${config.colorScheme.palette.base0E}";
          marker = "#${config.colorScheme.palette.base0D}";
          spinner = "#${config.colorScheme.palette.base0B}";
          header = "#${config.colorScheme.palette.base0D}";
        };
        */
      };
      fd = {
        enable = true;
        hidden = true;
        ignores = [
          ".git/"
          "*.bak"
          "$RECYCLE.BIN"
          "'System Volume Information/'"
          "lost+found"
        ];
      };
      eza = {
        enable = true;
        enableZshIntegration = true;
        icons = true;
        extraOptions = [
          "--colour=auto"
          "--group-directories-first"
        ];
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
        history = {
          size = 10000;
          save = 50000;
          share = true;
          extended = true;
          ignoreDups = true;
          ignoreSpace = true;
          expireDuplicatesFirst = true;
          path = "${config.xdg.dataHome}/zsh/zsh_history";
        };
        plugins = [
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.8.0";
              sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
            };
          }
        ];
        initExtra = ''
          fastfetch
        '';
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
      };
    };
  };
}
