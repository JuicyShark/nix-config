{ config, pkgs, ... }:
let
  shaders_dir = "${pkgs.mpv-shim-default-shaders}/share/mpv-shim-default-shaders/shaders";
  colour = config.colorScheme.palette;
in
{
  home.packages = with pkgs; [
    #Pretty Fluff
    peaclock
    cmatrix
    pipes
    streamlink #pipe twitch/youtube streams into terminal
    smassh # typing test
    ffmpeg
  ];
  programs = {
    kitty = {
		enable = true;
		settings = {
      confirm_os_window_close = 0;
      hide_window_decorations = "yes";
      notify_on_cmd_finish = "always 30.0 command notify-send 'job finished with status: %s' %c";

      shell = ".";
      editor = "VISUAL";
      allow_remote_control = "yes";
      linux_display_server = "wayland";
      font_size = 13;
      term = "xterm-kitty";
      window_alert_on_bell = "yes";
      enable_audio_bell = "no";
      scrollback_pager = "nvim";
      #Symbols from font Patches
      /* symbol_map = [
        "U+E5FA-U+E62B Symbols Nerd Font Mono"
        "U+e700-U+e7c5 Symbols Nerd Font Mono"
        "U+f000-U+f2e0 Symbols Nerd Font Mono"
        "U+e200-U+e2a9 Symbols Nerd Font Mono"
        "U+f1af0 Symbols Nerd Font Mono"
        "U+e300-U+e3e3 Symbols Nerd Font Mono"
        "U+f400-U+f532 Symbols Nerd Font Mono"
        "U+2665 Symbols Nerd Font Mono"
        "U+26A1 Symbols Nerd Font Mono"
        "U+e0a0-U+e0a2 Symbols Nerd Font Mono"
        "U+e0b0-U+e0b3 Symbols Nerd Font Mono"
        "U+e0b4-U+e0c8 Symbols Nerd Font Mono"
        "U+e0cc-U+e0d4 Symbols Nerd Font Mono"
        "U+e0a3 Symbols Nerd Font Mono"
        "U+e0ca Symbols Nerd Font Mono"
        "U+23fb-U+23fe Symbols Nerd Font Mono"
        "U+2b58 Symbols Nerd Font Mono"
        "U+f300-U+f32f Symbols Nerd Font Mono"
        "U+e000-U+e00a Symbols Nerd Font Mono"
        "U+ea60-U+ebeb Symbols Nerd Font Mono"
        "U+e276c-U+2771 Symbols Nerd Font Mono"
        "U+2500-U+259f Symbols Nerd Font Mono"
      ]; */

      # Performance
      input_delay = 0;
      rpaint_delay = 2;
      sync_to_monitor = "no";
      wayland_enable_ime = "no";

      # URL's
      open_url_with = "default";
      url_style = "curly";
      url_prefixes = "file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh";
      underline_hyperlinks = "always";

      # Layout
      remember_window_size = "no";
      enabled_layouts = "Tall, Fat, Splits";
      window_resize_step_cells = "3";
      window_resize_step_lines = "3";
      window_border_width = "0.5pt";
      window_margin_width = "-1";
      window_padding_width = "-1";
      single_window_margin_width = "-1";
      draw_minimal_borders = "yes";

      placement_strategy = "bottom-left";
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";

      # Colours
			background = "#${colour.base00}";
			foreground = "#${colour.base05}";
			selection_background = "#${config.colorScheme.palette.base0D}";
			selection_foreground = "#${config.colorScheme.palette.base00}";
      active_border_color = "#${colour.base0D}";
      inactive_border_color = "#${colour.base02}";
      bell_border_color = "#${colour.base06}";
      url_color = "#${config.colorScheme.palette.base04}";
			cursor = "#${config.colorScheme.palette.base05}";
			color0 = "#${config.colorScheme.palette.base03}";
			color1 = "#${config.colorScheme.palette.base08}";
			color2 = "#${config.colorScheme.palette.base0B}";
			color3 = "#${config.colorScheme.palette.base0A}";
			color4 = "#${config.colorScheme.palette.base0D}";
			color5 = "#${config.colorScheme.palette.base0E}";
			color6 = "#${config.colorScheme.palette.base0C}";
			color7 = "#${config.colorScheme.palette.base05}";
			color8 = "#${config.colorScheme.palette.base04}";
			color9 = "#${config.colorScheme.palette.base08}";
			color10 = "#${config.colorScheme.palette.base0B}";
			color11 = "#${config.colorScheme.palette.base0A}";
			color12 = "#${config.colorScheme.palette.base0D}";
			color13 = "#${config.colorScheme.palette.base0E}";
			color14 = "#${config.colorScheme.palette.base0C}";
			color15 = "#${config.colorScheme.palette.base0B}";
		};
		font = {
			name = config.font;
		};
		shellIntegration.enableZshIntegration = true;
  };
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

cava = {
    enable = true;
    settings = {
      general = {
        framerate = 120;
        autosens = 1;
        sesitivity = 115;
        bars = 0;
        bar_width = 3;
        bar_spacing = 0;
        sleep_timer = 380;
      };
      input = {
        method = "pipewire";
        source = "auto";
        channels = "stereo";
      };
      color = {
        background = "default";
        foreground = "default";
        gradient = 1;
        gradient_count = 4;
        # Requires extra set of string for config to read
        gradient_color_1 = "'#${config.colorScheme.palette.base0E}'";
        gradient_color_2 = "'#${config.colorScheme.palette.base0D}'";
        gradient_color_3 = "'#${config.colorScheme.palette.base0C}'";
        gradient_color_4 = "'#${config.colorScheme.palette.base0B}'";
      };

      smoothing = {
        noise_reduction = 45;
      };
    };
  };
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

