{ config, ... }:
{
  programs = {
    fzf = {
      enable = false;
      enableZshIntegration = true;
      defaultOptions = [
        "--height 40%"
        "--border rounded"
        "--min-height 17"
        "--preview bat"
      ];
      colors = {
        fg = "#${config.colorScheme.palette.base0B}";
        bg = "#${config.colorScheme.palette.base00}";
        hl = "#${config.colorScheme.palette.base0E}";
        "fg+" = "#${config.colorScheme.palette.base0D}";
        "bg+" = "#${config.colorScheme.palette.base00}";
        "hl+" = "#${config.colorScheme.palette.base0D}";
        info = "#${config.colorScheme.palette.base0E}";
        prompt = "#${config.colorScheme.palette.base0F}";
        pointer = "#${config.colorScheme.palette.base0E}";
        marker = "#${config.colorScheme.palette.base0D}";
        spinner = "#${config.colorScheme.palette.base0B}";
       header = "#${config.colorScheme.palette.base0D}";
      };
    };
    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
        "*.bak"
        "$RECYCLE.BIN"
        "'System Volume Information/'"
        "lost+found"
      ];
    };
    ripgrep = {
      enable = true;
    };
  };
}
