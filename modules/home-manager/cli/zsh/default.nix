{ pkgs, config,  ... }:
{
  imports = [
    ./bat.nix
    ./eza.nix
    ./bottom.nix
    ./starship.nix
    ./fastfetch.nix
    ./fzf.nix
    ./man.nix
    ./yt-dlp.nix
    ./direnv.nix
  ];
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
		  enable = true;
		  enableCompletion = true;
      dotDir = ".config/zsh";
		  history = {
			  size = 100000;
			  save = 100000;
			  share = true;
			  extended = true;
			  ignoreDups = true;
			  ignoreSpace = true;
			  expireDuplicatesFirst = true;
			  path = "${config.xdg.dataHome}/zsh/zsh_history";
		  };
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#$(${pkgs.hostname}/bin/hostname -s)";  
        test = "sudo nixos-rebuild test --flake ${config.home.homeDirectory}/nixos#$(${pkgs.hostname}/bin/hostname -s)";
        ff = "$EDITOR $(${pkgs.fzf}/bin/fzf --preview '${pkgs.bat}/bin/bat {}')";
        rebuildclean = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#$(${pkgs.hostname}/bin/hostname -s) --upgrade && nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo nix-store --optimise";
        upgrade = "nix flake update ${config.home.homeDirectory}/nixos && sudo nixos-rebuild switch";
			  cd = "z";
        ls = "eza --group-directories-first -a --colour=always --icons=always";
        cat = "bat";
        btop = "btm";
        nixconfig =  "nvim ${config.home.homeDirectory}/nixos";
        notes = "nvim -c 'Neorg index'";
        journal = "nvim -c 'Neorg journal today'";
        grep = "ripgrep";  
        dante = "ssh juicy@192.168.54.60 -p 2033";
        juicy = "ssh juicy@192.168.54.54 -p 2033";
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
}
