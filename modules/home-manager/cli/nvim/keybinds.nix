{config, ...}: {
  programs.nixvim.keymaps =
    [
      {
        # [F]ind things, mainly uses Telescope
        mode = ["n" "v"];
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "[F]ind [F]iles";
        };
      }
      {
        mode = ["n" "v" "i"];
        key = "<C-f>";
        action = "<cmd>Tele find_files<CR>";
        options = {
          desc = "[F]ind [F]iles";
          silent = true;
          nowait = true;
        };
      }
      {
        mode = ["n" "v" "i"];
        key = "<C-f>";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "[F]ind [F]iles";
          silent = true;
          nowait = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>fh";
        action = "<cmd>Telescope harpoon marks<CR>";
        options = {
          desc = "[F]ind [H]arpoons";
          silent = true;
          nowait = true;
        };
      }
      {
        mode = ["n" "v" "i"];
        key = "<C-h>";
        action = "<cmd>Telescope harpoon marks<CR>";
        options = {
          desc = "[F]ind [H]arpoons";
          silent = true;
          nowait = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          desc = "[F]ind w/ [G]rep";
          nowait = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options = {
          desc = "[F]ind [B]uffers";
          nowait = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>f?";
        action = "<cmd>Telescope help_tags<CR>";
        options = {
          desc = "The [F]uck[?]";
          nowait = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>?";
        action = "<cmd>Telescope help_tags<CR>";
        options = {
          silent = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>ft";
        action = "<cmd>TodoTrouble<CR>";
        options = {
          desc = "[F]ind [T]odo's";
          nowait = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>d";
        action = "<cmd>Trouble<CR>";
        options = {
          desc = "Grep";
          nowait = true;
        };
      }
      # Git
      {
        mode = ["n" "v"];
        key = "<leader>gc";
        action = "<cmd>Neogit commit<CR>";
        options = {
          desc = "[G]it [C]ompete";
        };
      }

      # Misc
      {
        mode = "n";
        key = "<leader>.";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "Open Explorer";
      }
      {
        mode = ["n" "v"];
        key = "<Down>";
        options.silent = true;
        options.noremap = true;
        action = "gj";
      }
      {
        mode = ["n" "v"];
        key = "<Up>";
        options.silent = true;
        options.noremap = true;
        action = "gk";
      }
    ]
    ++ (
      if config.home.username == "juicy"
      then [
        ## [N]eorg / [N]otes Binds
        {
          mode = "n";
          key = "<leader>nt";
          action = "<cmd>Neorg journal today<CR>";
          options = {
            desc = "Open Journal";
          };
        }
        {
          mode = "n";
          key = "<leader>nn";
          action = "<Plug>(neorg.tempus.insert-date-insert-mode)";
          options = {
            #buffer = "norg";
            desc = "Insert Date";
          };
        }
      ]
      else [
        {
          mode = "n";
          key = "<leader>nn";
          options.silent = true;
          action = "<cmd>ObsidianNew<CR>";
        }
        {
          mode = "n";
          key = "<leader>n/";
          options.silent = true;
          action = "<cmd>ObsidianSearch<CR>";
        }
        {
          mode = "n";
          key = "<leader>nf";
          options.silent = true;
          action = "<cmd>ObsidianFollowLink<CR>";
        }
        {
          mode = "n";
          key = "<leader>nb";
          options.silent = true;
          action = "<cmd>ObsidianBacklinks<CR>";
        }
        {
          mode = "n";
          key = "<leader>no";
          options.silent = true;
          action = "<cmd>ObsidianOpen<CR>";
        }
      ]
    );

  programs.nixvim.plugins.which-key = {
    enable = true;
    showHelp = true;
    plugins = {
      marks = true;
      registers = true;
      presets = {
        g = true;
        motions = true;
        nav = false;
        operators = true;
        textObjects = true;
        windows = false;
        z = true;
      };
      spelling = {
        enabled = true;
        suggestions = 8;
      };
    };
    window = {
      border = "rounded";
      position = "bottom";
    };
    layout = {
      align = "center";
      height = {
        max = 20;
        min = 6;
      };
      width = {
        max = 75;
        min = 45;
      };
    };
    hidden = ["<silent>" "<cmd>" "<Cmd>" "<CR>" "^:" "^ " "^call " "^lua "];
    triggersNoWait = ["`" "'" "g`" "g'" "\"" "<c-r>" "z="];
    /*
      registrations = {
      "<leader>n" = "[N]otes";
      "<leader>f" = "[F]ind";
      "<leader>h" = "[H]arpoon that B*";
      "<leader>g" = "[G]it";
    };
    */
  };
}
