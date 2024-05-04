{ inputs, pkgs, ...}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./neorg.nix
    ./keybinds.nix
    ./completion.nix
  ];

	home.packages = with pkgs; [

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
    globals = {
      mapleader = " ";
      maplocalleader = " ";

      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };


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
      hidden = true;
      swapfile = false;
      scrolloff = 8;
      expandtab = true;
      autoindent = true;
  	};
  	

    plugins = {
      /* Rust */
      rustaceanvim.enable = true;

      /* Telescope */
      telescope = {
        enable = true;

        keymaps = {
          # Find files using Telescope command-line sugar.
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>b" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fd" = "diagnostics";

          # FZF like bindings
          "<C-p>" = "git_files";
          "<leader>p" = "oldfiles";
          "<C-f>" = "live_grep";
        };
        keymapsSilent = true;

        settings.defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
          pickers.find_files.hidden = true;
        };
      };

      which-key = {
        enable = false;
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

   #   openscad.enable = true;
   #   godot.enable = true;

      /* Pretty */
      nix.enable = true;
      illuminate.enable = true;
      treesitter.enable = true;
      /* QOL */
      nvim-autopairs.enable = true;
      indent-blankline.enable = true;
      todo-comments.enable = true;
      conform-nvim.enable = true;
      lualine.enable = true;
      auto-save.enable = true;
   #   neogen.enable = true;

      /* Color preview */
      nvim-colorizer.enable = true;

      /* Dependencies */
      dap.enable = true;
    };
    autoCmd = [
      {
        event = "VimEnter";
        command = "set nofoldenable";
        desc = "Unfold All";
      }
      {
        event = "BufWrite";
        command = "%s/\\s\\+$//e";
        desc = "Remove Whitespaces";
      }
      {
        event = "FileType";
        pattern = [ "markdown" "norg" ];
        command = "setlocal conceallevel=2";
        desc = "Conceal Syntax Attribute";
      }
      {
        event = "FileType";
        pattern = [ "markdown" "norg" ];
        command = "setlocal spell spelllang=en,nl";
        desc = "Spell Checking";
      }
      {
        event = "FileType";
        pattern = [ "markdown" ];
        command = "setlocal scrolloff=30 | setlocal wrap";
        desc = "Fixed cursor location on markdown (for preview) and enable wrapping";
      }
      {
        event = "FileType";
        pattern = "help";
        command = "wincmd L";
      }

    ];
  };
}
