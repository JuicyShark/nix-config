{ ... }:
{
	programs.nixvim = {
    		enable = true;
		defaultEditor = true;
		colorschemes.catppuccin = {
			enable = true;
			flavour = "mocha";
			transparentBackground = true;
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
					vim.opt_local.conceallevel = 2;
				};
			};
		};
		#extraConfigLua = builtins.readFile ./init.lua;
		plugins = {
		/* Note Taking */
		neorg = {
			enable = true;
			lazyLoading = false;
			modules = {
				"core.defaults" = {
					__empty = null;
				};
				"core.completion" = {
					config = {
						engine = "nvim-cmp";
					};
				};
				"core.dirman" = {
					config = {
						workspaces = {
							home = "~/documents/Notes";
							projects = "~/documents/Notes/Projects";
							games = "~/documents/Notes/Games"; 
						};
						default_workspace = "home";
						index = "index.norg";
						use_popup = "true";
					};
				};
				"core.journal" = {
					config = {
						journal_folder = "~/documents/Journal";
						strategy = "nested";
					};
				};
				"core.ui.calendar" = {
					__empty = null;
				};
				"core.concealer" = {
					config = {
						folds = true;
						icon_preset = "varied";
						init_open_folds = "never";
					};
				};
			};
		};
		
#		obsidian = {
#			enable = true;
#			settings = {
#				dir = "~/documents/Notes";
#				daily_notes.folder = "~/documents/Notes/journal";
#				picker.name = "telescope.nvim";
#			};
#		};
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

		/* LSP */
		lsp = {
			enable = true;
			servers = {
				nil_ls.enable = true;
				lua-ls.enable = true;
			};
		};
		lsp-format.enable = true;
		openscad.enable = true;
		/* Pretty */
		/*startup = {
			enable = true;
			sections = {
 				body = {
    					align = "center";
    					content = [
      						[
        						" Search For File"
        						"Telescope find_files"
        						"<leader>ff"
						]
      						[
        						" File Browser"
        						"Telescope file_browser"
        						"<leader>fb"
      						]
						[
							"New Obsidian Note"
							"ObsidianNew"
							"<leader>on"
						]
      						[
        						"Open Today's Journal"
        						"ObsidianToday"
        						"<leader>ot"
      						]
						[
							"Check Dailies"
							"ObsidianDailies"
							"<leader>od"
						]
     	 					[
        						" New File"
        						"lua require'startup'.new_file()"
        						"<leader>nf"
      						]
    					];
    					defaultColor = "";
    					foldSection = true;
    					highlight = "String";
    					margin = 5;
    					oldfilesAmount = 0;
    					title = "Basic Commands";
    					type = "mapping";
  				};
  				header = {
    					align = "center";
    						content = {
      							__raw = "require('startup.headers').hydra_header";
    						};
    					defaultColor = "";
    					foldSection = false;
    					highlight = "Statement";
    					margin = 5;
    					oldfilesAmount = 0;
   					title = "Header";
    					type = "text";
  				};
			};
		};*/

		nix.enable = true;
		
		/* Makes code look nicer */
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


		keymaps = [
			{
       				mode = "n";
        			key = "<leader>ff";
        			options.silent = true;
        			action = "<cmd>Telescope find_files<CR>";
      			}
			{
				mode = "n";
				key = "<leader>.";
				options.silent = true;
				action = "<cmd>Explore<CR>";
			}
			{	
				mode = "n";
				key = "<leader>/";
				options.silent = true;
				action = "<cmd> Telescope find_files<CR>";
			}
			{
        			mode = "n";
        			key = "<leader>ot";
        			options.silent = true;
        			action = "<cmd>ObsidianToday<CR>";
      			}
			{
				mode = "n";
				key = "<leader>on";
				options.silent = true;
				action = "<cmd>ObsidianNew<CR>";
			}
			{
        			mode = "n";
        			key = "<leader>o.";
        			options.silent = true;
        			action = "<cmd>ObsidianSearch<CR>";
      			}
			{
        			mode = "n";
        			key = "<leader>of";
        			options.silent = true;
        			action = "<cmd>ObsidianFollowLink<CR>";
      			}
			{
        			mode = "n";
        			key = "<leader>ob";
        			options.silent = true;
        			action = "<cmd>ObsidianBacklinks<CR>";
      			}
			{
        			mode = "n";
        			key = "<leader>oo";
        			options.silent = true;
        			action = "<cmd>ObsidianOpen<CR>";
      			}
			{
				mode = "n";
				key = "<Down>";
      				options.silent = false;
				options.noremap = true;
				action = "gj";
			}
			{
				mode = "n";
				key = "<Up>";
        			options.silent = false;
				options.noremap = true;
				action = "gk";
			}
			{
				mode = "n";
				key = ":split";
        			options.silent = false;
				options.noremap = true;
				action = ":lua OpenWithRustScript()<CR>";
			}
			{
				mode = "n";
				key = ":vsplit";
        			options.silent = false;
				options.noremap = true;
				action = ":lua OpenWithRustScript()<CR>";
			}
		];
  	};
}
