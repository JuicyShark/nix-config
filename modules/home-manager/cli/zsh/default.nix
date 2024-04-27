{ pkgs, config,  ... }:
{
  imports = [
    ./bat.nix
    ./eza.nix
    ./bottom.nix
    ./starship.nix
    ./fastfetch.nix
    ./yazi.nix
    ./fzf.nix
    ./navi.nix
  ];
	programs.zsh = {
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
    };

  	plugins = [
  		{
  			name = "zsh-autosuggestions";
  			src = pkgs.fetchFromGitHub {
  		  	owner = "zsh-users";
    		  repo = "zsh-autosuggestions";
      	  rev = "v0.4.0";
        	sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
      	name = "syntax-highlighting";
				file = "zsh-syntax-highlighting.plugin.zsh";
				src = pkgs.fetchFromGitHub {
        	owner = "zsh-users";
        	repo = "zsh-syntax-highlighting";
        	rev = "master";
          sha256 = "sha256-4rW2N+ankAH4sA6Sa5mr9IKsdAg7WTgrmyqJ2V1vygQ=";
      	};
      }
  		{
  			name = "zsh-vi-mode";
  			src = pkgs.fetchFromGitHub {
    			owner = "jeffreytse";
    			repo = "zsh-vi-mode";
    			rev = "v0.11.0";
    			sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
    		};
    	}
    ];
    
    initExtra = ''
			fastfetch
		'';
  
  };  
  
  programs.zoxide.enable = true;

}
