{
  inputs,
  osConfig,
  pkgs,
  ...
}: let
  vimHyprNav = import ./plugins/vim-hypr-nav.nix {
    inherit (pkgs) stdenv fetchFromGitHub installShellFiles;
  };
in {
  # having a condition against config causes infinite recursion?
  imports =
    [
      inputs.nixvim.homeManagerModules.nixvim
      ./keybinds.nix
      ./completion.nix
    ]
    ++ (
      if osConfig.main-user == "jake"
      then [
        ./obsidian.nix
      ]
      else [
        ./neorg.nix
      ]
    );

  home.packages = [
    vimHyprNav
    pkgs.jq
    pkgs.fd
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withRuby = false;

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        integrations = {
          cmp = true;
          gitsigns = true;
          notify = true;
          nvimtree = true;
          treesitter = true;
        };
        styles = {
          booleans = [
            "bold"
            "italic"
          ];
          comments = [
            "italic"
          ];
          conditionals = [
            "bold"
          ];
          types = [
            "bold"
            "underline"
          ];
          variables = [
            "italic"
          ];
          strings = [
            "italic"
          ];
        };
        flavour = "mocha";
        background.dark = "mocha";
        background.light = "mocha";
        transparent_background = true;
        term_colors = true;
      };
    };
    globals = {
      mapleader = " ";
      maplocalleader = "<C-Space>";

      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;
      loaded_npm_provider = 0;
    };

    opts = {
      # Folds
      foldmethod = "syntax";
      #fold = 2;
      foldminlines = 6;
      foldnestmax = 3;

      # Whitespace
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      copyindent = true;

      linebreak = true;
      clipboard = "unnamedplus";
      cursorline = true;
      number = true;
      relativenumber = true;
      signcolumn = "number";

      updatetime = 300;
      termguicolors = true;
      mouse = "a";
      hidden = true;

      scrolloff = 3;

      # Misc
      swapfile = false;
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "vim-hypr-nav";
        src = vimHyprNav;
      })
      pkgs.vimPlugins.neorg-telescope
    ];

    plugins = {
      rustaceanvim.enable = true;
      telescope = {
        enable = true;

        settings.defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^result/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
          pickers.find_files.hidden = true;
        };
      };

      harpoon = {
        enable = true;
        enableTelescope = true;
        markBranch = true;
        projects = {
          "$HOME/documents/nixos-config" = {
            marks = [
              "$HOME/documents/nixos-config/modules/hosts/shared-system-configuration.nix"
              "$HOME/documents/nixos-config/modules/home-manager/users/shared-home-configuration.nix"
              "$HOME/documents/nixos-config/flake.nix"
            ];
          };
        };
        keymaps = {
          addFile = "<C-a>";
          navFile = {
            "1" = "<C-1>";
            "2" = "<C-2>";
            "3" = "<C-3>";
            "4" = "<C-4>";
          };
          navNext = "<C-e>";
          navPrev = "<C-q>";
          toggleQuickMenu = "<C-w>";
        };
      };

      copilot-chat = {
        enable = true;
        settings = {
          auto_insert_mode = true;
          context = "buffers";

          mappings = {
            accept_diff = {
              insert = "<C-y>";
              normal = "<C-y>";
            };
            close = {
              insert = "<C-c>";
              normal = "q";
            };
            complete = {
              detail = "Use @<Tab> or /<Tab> for options.";
              insert = "<Tab>";
            };
            reset = {
              insert = "<C-l>";
              normal = "<C-l>";
            };
            show_diff = {
              normal = "gd";
            };
            show_system_prompt = {
              normal = "gp";
            };
            show_user_selection = {
              normal = "gs";
            };
            submit_prompt = {
              insert = "<C-m>";
              normal = "<CR>";
            };
            yank_diff = {
              normal = "gy";
            };
          };
        };
      };

      # TODO setup FOLKE plugins
      trouble = {
        enable = true;
        settings = {
          auto_fold = true;
          #auto_open = true;
          group = true;
          height = 8;
          #   icons = true;
          use_diagnostic_signs = true;
          posistion = "bottom";
        };
      };
      # File Explorer
      nvim-tree = {
        enable = true;
        autoReloadOnWrite = true;
        autoClose = true;
        disableNetrw = true;
        hijackCursor = true;
        hijackUnnamedBufferWhenOpening = true;
        openOnSetup = true;
        openOnSetupFile = true;
      };
      edgy = {
        enable = true;
        settings = {
          left = [
            {
              ft = "NvimTree";
              title = "Explorer";
              #       size = 25;
            }
            {
              ft = "Outline";
              open = "SymbolsOutline";
            }
            {
              ft = "dapui_scopes";
            }
            {
              ft = "dapui_breakpoints";
            }
          ];
        };
      };

      noice = {
        enable = true;
        cmdline.view = "cmdline";
      };

      # Pretty
      # TODO Breaks Neorg Concealer
      headlines = {
        enable = true;
        settings.norg = {
          headline_highlights = ["Headline"];
          bullet_highlights = [
            "@neorg.headings.1.prefix"
            "@neorg.headings.2.prefix"
            "@neorg.headings.3.prefix"
            "@neorg.headings.4.prefix"
            "@neorg.headings.5.prefix"
            "@neorg.headings.6.prefix"
          ];
          bullets = ["◉" "○" "✸" "✿"];
          codeblock_highlight = "CodeBlock";
          dash_highlight = "Dash";
          dash_string = "-";
          doubledash_highlight = "DoubleDash";
          doubledash_string = "=";
          quote_highlight = "Quote";
          quote_string = "┃";
          fat_headlines = true;
          fat_headline_upper_string = "▃";
          fat_headline_lower_string = "🬂";
        };
      };
      image = {
        enable = false;
        backend = "ueberzug";
        maxHeight = 480;
        maxHeightWindowPercentage = 50;
        integrations.neorg = {
          enabled = true;
          downloadRemoteImages = true;
        };
      };
      gitsigns.enable = true;
      notify = {
        enable = true;
        fps = 120;
        level = "info";
        maxHeight = 42;
        maxWidth = 35;
        minimumWidth = 200;
        render = "default";
        timeout = 3750;
        topDown = true;
      };
      nix.enable = true;
      illuminate.enable = true;
      treesitter = {
        enable = true;
        folding = true;
        nixvimInjections = true;
        nodejsPackage = null;
        nixGrammars = true;
        grammarPackages = with pkgs.tree-sitter-grammars; [
          tree-sitter-norg
          tree-sitter-norg-meta
          tree-sitter-zig
          tree-sitter-rust
          tree-sitter-toml
          tree-sitter-lua
          tree-sitter-css
          tree-sitter-json
          tree-sitter-python
          tree-sitter-ledger
          tree-sitter-godot-resource
        ];
        languageRegister = {
          norg = "norg";
          css = "css";
        };
        settings = {
          highlight.enable = true;
          incremental_selection.enable = true;
          indent.enable = true;
        };
      };

      /*
      QOL
      */
      neoscroll = {
        enable = true;
        settings = {
          cursor_scrolls_alone = true;
          easing_function = "quadratic";
          hide_cursor = true;
          mappings = [
            "<C-u>"
            "<C-d>"
            "<C-b>"
            "<C-f>"
            "<C-y>"
            "<C-e>"
            "zt"
            "zz"
            "zb"
          ];
          respect_scrolloff = true;
          stop_eof = true;
        };
      };
      startup = {
        enable = true;
        theme = "dashboard";
      };
      surround.enable = true;
      todo-comments.enable = true;
      lualine.enable = true;
      auto-save.enable = true;
      auto-save.settings.debounce_delay = 100000;
      nvim-colorizer.enable = true;

      dap.enable = true;
    };
    autoCmd = [
      {
        event = "BufWrite";
        command = "%s/\\s\\+$//e";
        desc = "Remove Whitespaces";
      }
      {
        event = "FileType";
        pattern = ["norg"];
        command = "setlocal conceallevel=1";
        desc = "Conceal Syntax Attribute";
      }
      {
        event = "FileType";
        pattern = ["norg"];
        command = "setlocal concealcursor=n";
        desc = "Conceal line when not editing";
      }
      {
        event = "FileType";
        pattern = "help";
        command = "wincmd L";
      }
    ];
  };
}
