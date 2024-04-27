{ config, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;



    theme = {
      manager = {
        cwd = { fg = "#${config.colorScheme.palette.base0C}"; };
        # Hovered
        hovered = { fg = "#${config.colorScheme.palette.base00}"; bg = "#${config.colorScheme.palette.base0D}"; };
        preview_hovered = { underline = true; };
        # Find
        find_keyword  = { fg = "#${config.colorScheme.palette.base0A}"; italic = true;};
        find_position = { fg = "#${config.colorScheme.palette.base06}"; bg = "reset"; italic = true; };
        # Marker
        marker_copied = { fg = "#${config.colorScheme.palette.base0B}"; bg = "#${config.colorScheme.palette.base0B}"; };
        marker_cut      = { fg = "#${config.colorScheme.palette.base08}"; bg = "#${config.colorScheme.palette.base08}"; };
        marker_selected = { fg = "#${config.colorScheme.palette.base0D}"; bg = "#${config.colorScheme.palette.base0D}"; };
        # Tab
        tab_active   = { fg = "#${config.colorScheme.palette.base00}"; bg = "#${config.colorScheme.palette.base05}"; };
        tab_inactive = { fg = "#${config.colorScheme.palette.base05}"; bg = "#${config.colorScheme.palette.base03}"; };
        tab_width    = 1;
        # Count
        count_copied   = { fg = "#${config.colorScheme.palette.base00}"; bg = "#${config.colorScheme.palette.base0B}"; };
        count_cut      = { fg = "#${config.colorScheme.palette.base00}"; bg = "#${config.colorScheme.palette.base08}"; };
        count_selected = { fg = "#${config.colorScheme.palette.base00}"; bg = "#${config.colorScheme.palette.base0D}"; };
        # Border
        border_symbol = "│";
        border_style  = { fg = "#${config.colorScheme.palette.base0E}"; };
        # Highlighting
        syntect_theme = "~/nixos/modules/home-manager/cli/Catppuccin-mocha.tmTheme";
      };
      status = {
        separator_open  = "";
        separator_close = "";
        separator_style = { fg = "#${config.colorScheme.palette.base03}"; bg = "#${config.colorScheme.palette.base03}"; };
        # Mode
        mode_normal = { fg = "#${config.colorScheme.palette.base00}"; bg = "#${config.colorScheme.palette.base0D}"; bold = true; };
        mode_select = { fg = "#${config.colorScheme.palette.base00}"; bg = "#${config.colorScheme.palette.base0B}"; bold = true; };
        mode_unset  = { fg = "#${config.colorScheme.palette.base00}"; bg = "#${config.colorScheme.palette.base0F}"; bold = true; };
        # Progress
        progress_label  = { fg = "#${config.colorScheme.palette.base0E}"; bold = true; };
        progress_normal = { fg = "#${config.colorScheme.palette.base0D}"; bg = "#${config.colorScheme.palette.base03}"; };
        progress_error  = { fg = "#${config.colorScheme.palette.base08}"; bg = "#${config.colorScheme.palette.base03}"; };
        # Permissions
        permissions_t = { fg = "#${config.colorScheme.palette.base0D}"; };
        permissions_r = { fg = "#${config.colorScheme.palette.base0A}"; };
        permissions_w = { fg = "#${config.colorScheme.palette.base08}"; };
        permissions_x = { fg = "#${config.colorScheme.palette.base0B}"; };
        permissions_s = { fg = "#${config.colorScheme.palette.base0E}"; };
      };
      input = {
        border   = { fg = "#${config.colorScheme.palette.base0D}"; };
        title    = {};
        value    = {};
        selected = { reversed = true; };
      };
      select = {
        border   = { fg = "#${config.colorScheme.palette.base0D}"; };
        active   = { fg = "#${config.colorScheme.palette.base06}"; };
        inactive = {};
      };
      tasks = {
        border  = { fg = "#${config.colorScheme.palette.base0D}"; };
        title   = {};
        hovered = { underline = true; };
      };
      which = { 
        mask            = { bg = "#${config.colorScheme.palette.base02}"; };
        cand            = { fg = "#${config.colorScheme.palette.base0C}"; };
        rest            = { fg = "#${config.colorScheme.palette.base0E}"; };
        desc            = { fg = "#${config.colorScheme.palette.base06}"; };
        separator       = "  ";
        separator_style = { fg = "#${config.colorScheme.palette.base04}"; };
      };
      help = {
        on      = { fg = "#${config.colorScheme.palette.base06}"; };
        exec    = { fg = "#${config.colorScheme.palette.base0C}"; };
        desc    = { fg = "#${config.colorScheme.palette.base0E}"; };
        hovered = { bg = "#${config.colorScheme.palette.base04}"; bold = true; };
        footer  = { fg = "#${config.colorScheme.palette.base03}"; bg = "#${config.colorScheme.palette.base05}"; };
      };
      filetype = {
        rules = [
	        # Images
          { mime = "image/*"; fg = "#${config.colorScheme.palette.base0C}"; }
    	    # Videos
    	    { mime = "video/*"; fg = "#${config.colorScheme.palette.base0A}"; }
	        { mime = "audio/*"; fg = "#${config.colorScheme.palette.base0A}"; }
    	    # Archives
    	    { mime = "application/zip";             fg = "#${config.colorScheme.palette.base06}"; }
	        { mime = "application/gzip";            fg = "#${config.colorScheme.palette.base06}"; }
	        { mime = "application/x-tar";           fg = "#${config.colorScheme.palette.base06}"; }
	        { mime = "application/x-bzip";          fg = "#${config.colorScheme.palette.base06}"; }
	        { mime = "application/x-bzip2";         fg = "#${config.colorScheme.palette.base06}"; }
	        { mime = "application/x-7z-compressed"; fg = "#${config.colorScheme.palette.base06}"; }
	        { mime = "application/x-rar";           fg = "#${config.colorScheme.palette.base06}"; }
	        # Fallback
	        { name = "*"; fg = "#${config.colorScheme.palette.base05}"; }
	        { name = "*/"; fg = "#${config.colorScheme.palette.base0D}"; }
        ];
      };
    };
  };
}
