{
  programs.nixvim = {
    opts.completeopt = [ "menu" "menuone" "noselect" ];

    plugins = {
    # luasnip currently disabled due to missing dependancy
    # https://github.com/NixOS/nixpkgs/issues/306367
    # luasnip.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          #snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };

        };
      };
      cmp-rg.enable = true;
      cmp-zsh.enable = true;
      cmp-nvim-lsp.enable = true;

      # LSP
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };
        servers = {
          nil_ls.enable = true;
          lua-ls.enable = true;
          rust-analyzer = {
            enable = true;
            filetypes = [ "toml" "rs" ];
            installCargo = false;
            installRustc = false;
          };
        };
      };
      lsp-format.enable = true;
      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources = {
          formatting = {
            nixpkgs_fmt.enable = false;
            markdownlint.enable = true;
          };
        };
      };
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
         #   luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
          };
        };
      };
    };
  };
}
