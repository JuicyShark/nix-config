{
  config,
  pkgs,
  ...
}: let
  shaders_dir = "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders";
in {
  programs = {
    mpv = {
      enable = true;
      bindings = {
        UP = "add volume +2";
        DOWN = "add volume -2";
      };

      scripts = [
        pkgs.mpvScripts.mpris
        #   pkgs.mpvScripts.mpv-notify-send
        pkgs.mpvScripts.youtube-upnext
        pkgs.mpvScripts.uosc
        pkgs.mpvScripts.thumbfast
        pkgs.mpvScripts.sponsorblock
        pkgs.mpvScripts.mpv-cheatsheet
        pkgs.mpvScripts.dynamic-crop
      ];

      config = {
        # video
        profile = "gpu-hq";
        #gpu-api = "vulkan";
        gpu-context = "wayland";
        vo = "gpu-next";
        hwdec =
          if config.hardware.nvidia.open
          then "vdpau"
          else "vaapi";
        video-sync = "display-resample";
        interpolation = true;
        tscale = "oversample";
        cache = "yes";
        cache-secs = "500";
        keep-open = "yes";

        # network streaming
        demuxer-max-back-bytes = "50Mib";
        demuxer-max-bytes = "600Mib";
        demuxer-readahead-secs = 300;
        force-seekable = "yes"; # for seeking when not preloaded

        osc = false;
        border = false;
        ytdl-format = "bestvideo[height<=?1440]+bestaudio/best";

        # audio
        ao = "pipewire";
        alang = "eng,en";
        slang = "eng,en,enUS";
        sub-auto = "fuzzy";

        # shaders
        glsl-shader = "/home/${config.main-user}/.config/mpv/shaders/NVScaler.glsl";
        scale = "lanczos";
        cscale = "lanczos";
        dscale = "mitchell";
        deband = "yes";
        scale-antiring = 1;
      };
    };
    home.file.".config/yt-dlp/config".text = ''
      --cookies-from-browser "firefox:$HOME/.mozilla/firefox/default"
      --mark-watched
    '';
    yt-dlp = {
      enable = true;
      extraConfig = ''
        -o ${config.xdg.userDirs.videos}/youtube/%(title)s.%(ext)s
      '';
    };
  };
  home.file = {
    ".config/mpv/shaders/NVScaler.glsl".source = "${shaders_dir}/NVScaler.glsl";
  };
}
