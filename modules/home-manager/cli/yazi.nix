{config, ...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    initLua =
      # Lua
      ''
        function Status:render() return {} end

        local old_manager_render = Manager.render
        function Manager:render(area)
         return old_manager_render(self, ui.Rect { x = area.x, y = area.y, w = area.w, h = area.h + 1 })
        end
      '';

    settings = {
      manager = {
        ratio = [1 3 5];
        show_hidden = true;
        show_symlink = true;
        sort_dir_first = true;
        scrolloff = 4;
      };

      # Define rules on how to open files
      /*
        opener = {
        edit = [
          {run = "nvim '$@'", desc = 'nvim', block = true, for = 'unix'}

        ];
        reveal = [
          "{ run = '''exiftool '$1'; echo 'Press enter to exit'; read _''', block = true, desc = 'Show EXIF', for = 'unix' }
        ];
        play = [
         "{ run = `mpv '$@'`, orphan = true, for = 'unix' }"
        ];
        # TODO add wine execution
        windows_open = [
          "{ run = }"
        ];
        open = [
         "{ run = `xdg-open '$@'`, desc = 'Open' }"
        ];
      };
      # Define what files open with defined rules
      open = {
        prepend_rules = [
          "{ mome = 'text/*', use = 'edit' }"	        "{ name = '*.json', use = 'edit' }"
         "{ name = 'video/*', use = [ 'open', 'edit' ] }"
        ];
        append_rules = [
         "{ name = '*', use = 'my-fallback' }"
        ];
      };
      */

      preview = {
        max_width = 1280;
        max_height = 1280;
        image_filter = "triangle";
        image_quality = 90;
        sixel_fraction = 10;
      };

      tasks = {
        #image_bound = [ 1280 720 ];
      };
    };

    /*
      theme = {
      manager = {
        cwd = {fg = "#${config.colorScheme.palette.base0C}";};
        # Hovered
        hovered = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base0D}";
        };
        preview_hovered = {underline = true;};
        # Find
        find_keyword = {
          fg = "#${config.colorScheme.palette.base0A}";
          italic = true;
        };
        find_position = {
          fg = "#${config.colorScheme.palette.base06}";
          bg = "reset";
          italic = true;
        };
        # Marker
        marker_copied = {
          fg = "#${config.colorScheme.palette.base0B}";
          bg = "#${config.colorScheme.palette.base0B}";
        };
        marker_cut = {
          fg = "#${config.colorScheme.palette.base08}";
          bg = "#${config.colorScheme.palette.base08}";
        };
        marker_selected = {
          fg = "#${config.colorScheme.palette.base0D}";
          bg = "#${config.colorScheme.palette.base0D}";
        };
        # Tab
        tab_active = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base05}";
        };
        tab_inactive = {
          fg = "#${config.colorScheme.palette.base05}";
          bg = "#${config.colorScheme.palette.base03}";
        };
        tab_width = 1;
        # Count
        count_copied = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base0B}";
        };
        count_cut = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base08}";
        };
        count_selected = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base0D}";
        };
        # Border
        border_symbol = "│";
        border_style = {fg = "#${config.colorScheme.palette.base0E}";};
        # Highlighting
        syntect_theme = "~/documents/nixos-config/modules/home-manager/cli/Catppuccin-mocha.tmTheme";
      };
      status = {
        separator_open = "";
        separator_close = "";
        separator_style = {
          fg = "#${config.colorScheme.palette.base03}";
          bg = "#${config.colorScheme.palette.base03}";
        };
        # Mode
        mode_normal = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base0D}";
          bold = true;
        };
        mode_select = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base0B}";
          bold = true;
        };
        mode_unset = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base0F}";
          bold = true;
        };
        # Progress
        progress_label = {
          fg = "#${config.colorScheme.palette.base0E}";
          bold = true;
        };
        progress_normal = {
          fg = "#${config.colorScheme.palette.base0D}";
          bg = "#${config.colorScheme.palette.base03}";
        };
        progress_error = {
          fg = "#${config.colorScheme.palette.base08}";
          bg = "#${config.colorScheme.palette.base03}";
        };
        # Permissions
        permissions_t = {fg = "#${config.colorScheme.palette.base0D}";};
        permissions_r = {fg = "#${config.colorScheme.palette.base0A}";};
        permissions_w = {fg = "#${config.colorScheme.palette.base08}";};
        permissions_x = {fg = "#${config.colorScheme.palette.base0B}";};
        permissions_s = {fg = "#${config.colorScheme.palette.base0E}";};
      };
      input = {
        border = {fg = "#${config.colorScheme.palette.base0D}";};
        title = {};
        value = {};
        selected = {reversed = true;};
      };
      select = {
        border = {fg = "#${config.colorScheme.palette.base0D}";};
        active = {fg = "#${config.colorScheme.palette.base06}";};
        inactive = {};
      };
      tasks = {
        border = {fg = "#${config.colorScheme.palette.base0D}";};
        title = {};
        hovered = {underline = true;};
      };
      which = {
        mask = {bg = "#${config.colorScheme.palette.base02}";};
        cand = {fg = "#${config.colorScheme.palette.base0C}";};
        rest = {fg = "#${config.colorScheme.palette.base0E}";};
        desc = {fg = "#${config.colorScheme.palette.base06}";};
        separator = "  ";
        separator_style = {fg = "#${config.colorScheme.palette.base04}";};
      };
      help = {
        on = {fg = "#${config.colorScheme.palette.base06}";};
        exec = {fg = "#${config.colorScheme.palette.base0C}";};
        desc = {fg = "#${config.colorScheme.palette.base0E}";};
        hovered = {
          bg = "#${config.colorScheme.palette.base04}";
          bold = true;
        };
        footer = {
          fg = "#${config.colorScheme.palette.base03}";
          bg = "#${config.colorScheme.palette.base05}";
        };
      };
      filetype = {
        rules = [
          # Images
          {
            mime = "image/*";
            fg = "#${config.colorScheme.palette.base0C}";
          }
          # Videos
          {
            mime = "video/*";
            fg = "#${config.colorScheme.palette.base0A}";
          }
          {
            mime = "audio/*";
            fg = "#${config.colorScheme.palette.base0A}";
          }
          # Archives
          {
            mime = "application/zip";
            fg = "#${config.colorScheme.palette.base06}";
          }
          {
            mime = "application/gzip";
            fg = "#${config.colorScheme.palette.base06}";
          }
          {
            mime = "application/x-tar";
            fg = "#${config.colorScheme.palette.base06}";
          }
          {
            mime = "application/x-bzip";
            fg = "#${config.colorScheme.palette.base06}";
          }
          {
            mime = "application/x-bzip2";
            fg = "#${config.colorScheme.palette.base06}";
          }
          {
            mime = "application/x-7z-compressed";
            fg = "#${config.colorScheme.palette.base06}";
          }
          {
            mime = "application/x-rar";
            fg = "#${config.colorScheme.palette.base06}";
          }
          # Fallback
          {
            name = "*";
            fg = "#${config.colorScheme.palette.base05}";
          }
        ];
      };
    };
    */
  };
}
