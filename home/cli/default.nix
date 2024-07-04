{  pkgs, ... }:
let
  shaders_dir = "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders";
in
{
  imports = [
	  ./kitty.nix
    ./zsh
    ./nvim
    ./cava.nix
    ./yazi.nix
    ./git.nix
  ];
  home.packages = with pkgs; [

 mpv-shim-default-shaders
    #Pretty Fluff
    peaclock
    cmatrix
    pipes

    #Utilities
    ffmpeg
    glfw
    speedtest-cli

    streamlink #pipe twitch/youtube streams into terminal
    trippy # Network diagnostics
    viddy # Modern Watch command
    so #stackoverflow search
    smassh # typing test
    circumflex # HackerNews in the terminal

    dig # check dns list
    rustscan
    ffsend
    gitui

    gcc       # C compiler
    #   rust-bin.stable.latest.default # Rust Staple Toolchain


		/* nix tools */
		manix  # Nix pkg and options search

		/* Raspberry Pico */
		pico-sdk
		picotool
		minicom
  ];

  # Terminal Based Programs/Tools
  programs = {
    # Terminal Image Viewer
    imv.enable = true;

    # Video / Media
    mpv = {
      enable = true;
      bindings = {
        UP = "add volume +2";
        DOWN = "add volume -2";
      };

      scripts = [
        pkgs.mpvScripts.mpris
        #pkgs.mpvScripts.mpv-notify-send
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
        hwdec = "auto";
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
        ytdl-format = "bestvideo+bestaudio";

        # audio
        ao = "pipewire";
        alang = "eng,en,jpn,jp";
        slang = "enm,eng,en,enCA,enUS,jpn,jp";
        sub-auto = "fuzzy";
        subs-with-matching-audio = "yes"; # can be removed after 0.36.0'

        # shaders
        glsl-shader = "~~/shaders/NVScaler.glsl";
        scale = "lanczos";
        cscale = "lanczos";
        dscale = "mitchell";
        deband = "yes";
        scale-antiring = 1;
      };
    };
  };

   home.file = {
    ".config/mpv/shaders/NVScaler.glsl".source = "${shaders_dir}/NVScaler.glsl";
  };
}
