{ inputs, pkgs, ...}:
{
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim
    ./neorg.nix
    ./keybinds.nix
  ];
	
	home.packages = with pkgs; [
		clang-tools
	];

  programs.nixvim = {
		enable = true;
		defaultEditor = true;
		colorschemes.catppuccin = {
      enable = true;
      settings = {
			  flavour = "mocha";
        transparent_background = true;
        term_colors = true;
			};
  	};
		globals.mapleader = " ";
  	opts = {
  		linebreak = true;
  		clipboard = "unnamedplus";
  		cursorline = true;
  		number = true;
  		relativenumber = true;
  		signcolumn = "number";
  		tabstop = 2;
  		shiftwidth = 2;
  		updatetime = 300;
  		termguicolors = true;
  		mouse = "a";
  	};
  	files = {
  		"ftplugin/markdown.lua" = {
  			opts = {
  				conceallevel = 2;
  			};
  		};
  	};
		  
    plugins = {
      /* Rust */
      rustaceanvim.enable = true;

      /* Telescope */
      telescope.enable = true;

      /* CMP/snippets */
      cmp_luasnip.enable = true;
      friendly-snippets.enable = true;
      luasnip = {
	      enable = true;
      };
      
      cmp = {
	      enable = true;
	      autoEnableSources = true;
      };
      
      lsp = {
      	enable = true;
	      servers = {
		      nil_ls.enable = true;
		      lua-ls.enable = true;
		      rust-analyzer = {
			      enable = true;
		        filetypes = ["toml" "rs"];
		        installCargo = true;
			       installRustc = true;
		      };
	      };
      };
      which-key = {
        enable = true;
        showHelp = true;
        hidden = ["<silent>" "<cmd>" "<Cmd>" "<CR>" "^:" "^ " "^call " "^lua "];
      };
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<C-a>";
          navFile = { "1" = "<C-1>"; "2" = "<C-2>"; "3" = "<C-3>"; "4" = "<C-4>"; };
          navNext = "<C-e>";
          navPrev = "<C-q>";
          toggleQuickMenu = "<C-w>";
        };
      };
        
      lsp-format.enable = true;
      openscad.enable = true;
      godot.enable = true;
       
      /* Pretty */
      nix.enable = true;
      illuminate.enable = true;
      treesitter.enable = true;
      /* QOL */
      nvim-autopairs.enable = true;
      indent-blankline.enable = true;
      comment.enable = true;
      todo-comments.enable = true;
      conform-nvim.enable = true;
      lualine.enable = true;
      /* Color preview */
      nvim-colorizer.enable = true;

      /* Dependencies */
      dap.enable = true;
    };
  };
}
