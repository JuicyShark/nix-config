{
  config,
  osConfig,
  pkgs,
  ...
}: {
  imports = [
    ./nvim
    ./yazi.nix
    ./bottom.nix
    ./fastfetch.nix
    ./starship.nix
    ./developer.nix
    ./man.nix
  ];

  config = {
    home.packages = with pkgs;
      [
        nix-output-monitor
        manix
        nix-index
        nix-tree
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

        gcc # C compiler
        /*
        nix tools
        */
        manix # Nix pkg and options search
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
        shellAliases = {
          rebuild = "sudo nixos-rebuild switch --flake ${config.xdg.userDirs.documents}/nixos-config#$(${pkgs.hostname}/bin/hostname -s) --log-format internal-json -v |& sudo ${pkgs.nix-output-monitor}/bin/nom --json";
          test = "sudo nixos-rebuild test --flake ${config.xdg.userDirs.documents}/nixos-config#$(${pkgs.hostname}/bin/hostname -s ) --log-format internal-json -v |& sudo ${pkgs.nix-output-monitor}/bin/nom --json";
          ff = "$EDITOR $(${pkgs.fzf}/bin/fzf --preview '${pkgs.bat}/bin/bat {}')";
          rebuildclean = "sudo nixos-rebuild switch --flake ${config.xdg.userDirs.documents}/nixos-config#$(${pkgs.hostname}/bin/hostname -s) --upgrade --log-format internal-json -v |& sudo ${pkgs.nix-output-monitor}/bin/nom --json && nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo nix-store --optimise";
          upgrade = "sudo nix flake update ${config.xdg.userDirs.documents}/nixos-config && nixos-rebuild switch --flake ${config.xdg.userDirs.documents}/nixos-config --log-format internal-json -v |& sudo ${pkgs.nix-output-monitor}/bin/nom --json";
          cd = "z";
          ls = "${pkgs.eza}/bin/eza";
          tree = "${pkgs.eza}/bin/eza --tree";
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
