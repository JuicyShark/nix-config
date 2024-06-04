{ config, ... }:
{
  programs.yt-dlp = {
    enable = true;
    extraConfig = ''
      -o ${config.xdg.userDirs.videos}/youtube/%(title)s.%(ext)s
    '';
  };
}
