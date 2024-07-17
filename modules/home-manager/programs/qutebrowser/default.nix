{ config, osConfig, lib, pkgs, ... }:
let
  isJuicy = config.home.username == "juicy";
  isViridian = config.home.username == "jake";
  i2p = osConfig.services.i2pd.proto.socksProxy.enable or osConfig.services.i2pd.proto.httpProxy.enable;
in
{
  imports = [

  ];
    /*home.persistence = {
    "/persist${config.home.homeDirectory}".directories = [
      ".config/qutebrowser/bookmarks"
      ".config/qutebrowser/greasemonkey"
      ".local/share/qutebrowser"
    ];
  };*/

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
    "text/xml" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/qute" = ["org.qutebrowser.qutebrowser.desktop"];
  };

  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = false;

    searchEngines = {
      DEFAULT = "https://search.brave.com/search?q={}";
      yt = "https://www.youtube.com/results?search_query={}";

    } // (if isViridian || isJuicy then {
      nw = "https://nixos.wiki/index.php?search={}";
      np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      no = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=package&query={}";
      nh = "https://mipmip.github.io/home-manager-option-search/?{}";
      }else {
      g = "https://google.com/search?q={}";
    });


    quickmarks = {
      sf = "https://facebook.com";
      sd = "https://discord.com";

      r = "https://reddit.com";
      yt = "https://www.youtube.com/feed/subscriptions";
      my = "https://www.youtube.com/feed/subscriptions";
      mn = "https://netflix.com";
      md = "https://disney.com";
      mb = "https://binge.com.au/";
      mp = "https://www.primevideo.com/";
      mj = "https://www.primevideo.com/"; # TODO add jellyfin url

    } // (if isJuicy then {
      sm = "https://mastodon.social";
    } else {

    }) // (if (isJuicy || isViridian) && i2p then {

    } else {});

    keyBindings = {
      normal = { } //
        (if config.programs.mpv.enable then {
          "ww" = "spawn ${config.programs.mpv.package}/bin/umpv {url}";
          "wW" = "hint links spawn ${config.programs.mpv.package}/bin/umpv {hint-url}')";
        } else { });
      };

    settings = {
      new_instance_open_target = "window";

      window = {
        transparent = true;
        title_format = "{current_title}";
      } // (if isJuicy then {
        hide_decoration = true;
      } else {
        hide_decoration = false;
      });

      tabs = {
        tabs_are_windows = isJuicy;
        show = (if isJuicy then "never" else "always");
      };

      url = (if isJuicy then {
        default_page = "https://search.brave.com";
        start_pages = [ "https://search.brave.com" ];
        open_base_url = false;
      } else {
        default_page = "https://search.brave.com";
        start_pages = [ "https://search.brave.com" ];
        open_base_url = false;
      });
      completion = {
        cmd_history_max_items = 250;
        height = "23%";
        use_best_match = true;
      };
      scrolling = {
        bar = (if isJuicy then "never" else "always");
        smooth = true;
      };

      fileselect = {
        handler = "external";
        folder.command = [ "kitty" "-e" "yazi" "--cwd-file" "{}" ];
        multiple_files.command = [ "kitty" "-e" "yazi" "--chooser-file" "{}" ];
        single_file.command = [ "kitty" "-e" "yazi" "--chooser-file" "{}" ];
      };

      editor.command = [ "kitty" "-e" "nvim" "{}" ];

      content = {
        fullscreen.window = true;
        default_encoding = "utf-8";
        autoplay = false;
        hyperlink_auditing = false;
        prefers_reduced_motion = true;
        dns_prefetch = false;
        geolocation = false;
        local_content_can_access_file_urls = true;
        local_content_can_access_remote_urls = false;
        canvas_reading = false;
        persistent_storage = true;
        notifications.enabled = true;
        register_protocol_handler = true;
        notifications.presenter = "libnotify";
        pdfjs = true;
      };
      hints = {
        auto_follow = "always";
        auto_follow_timeout = 0;
        border = "1px solid " + "${config.colorScheme.palette.base01}";

        chars = (if isJuicy then "arstneio" else "asdfghjkl");
        hide_unmatched_rapid_hints = false;
        leave_on_load = false;
        min_chars = 1;
        mode = "letter";
        uppercase = false;
      };

      statusbar = {
        widgets = ["keypress" "url" "search_match" "scroll" "progress"];
        position = "bottom";
        show = "always";
      };

      qt = {
        args = [ "disable-backing-store-limit" "enable-accelerated-video-decode" "disable-gpu-driver-bug-workarounds" ];
        chromium = {
          process_model =  "process-per-site-instance";
          low_end_device_mode = "never";
          sandboxing = "enable-all";
        };
      };
      input = {
        insert_mode = {
          auto_enter = true;
          auto_leave = true;
          auto_load = false;
          leave_on_load = true;
        };
        mouse = {
          back_forward_buttons = true;
          rocker_gestures = true;
        };
        links_included_in_focus_chain = true;
        match_counts = true;
        media_keys = true;
        spatial_navigation = false;
      };

      downloads.location = {
        prompt = true;
        remember = true;
        suggestion = "both";
      };
      colors = {
        webpage = {
          darkmode.enabled = true;
          darkmode.policy.page = "smart";
          preferred_color_scheme = "dark";

        };
        hints = {
          bg = "#${config.colorScheme.palette.base09}";
          fg = "#${config.colorScheme.palette.base01}";
          match.fg = "#${config.colorScheme.palette.base0D}";
        };
      };
    };
    extraConfig = ''


      c.fonts.web.size.default = 18
      c.fonts.web.size.default_fixed = 15
      c.fonts.web.size.minimum = 7
      c.fonts.web.size.minimum_logical = 9

      c.colors.completion.category.bg = "#${config.colorScheme.palette.base00}"
      c.colors.completion.category.border.bottom = "#${config.colorScheme.palette.base01}"
      c.colors.completion.category.border.top = "#${config.colorScheme.palette.base02}"
      c.colors.completion.category.fg = "#${config.colorScheme.palette.base0B}"
      c.colors.completion.even.bg = "#${config.colorScheme.palette.base01}"
      c.colors.completion.odd.bg = "#${config.colorScheme.palette.base02}"
      c.colors.completion.fg = "#${config.colorScheme.palette.base05}"
      c.colors.completion.item.selected.bg = "#${config.colorScheme.palette.base04}"
      c.colors.completion.item.selected.border.bottom = "#${config.colorScheme.palette.base04}"
      c.colors.completion.item.selected.border.top = "#${config.colorScheme.palette.base04}"
      c.colors.completion.item.selected.fg = "#${config.colorScheme.palette.base05}"
      c.colors.completion.item.selected.match.fg = "#${config.colorScheme.palette.base06}"
      c.colors.completion.match.fg = "#${config.colorScheme.palette.base05}"
      c.colors.completion.scrollbar.bg = "#${config.colorScheme.palette.base01}"
      c.colors.completion.scrollbar.fg = "#${config.colorScheme.palette.base04}"

      c.colors.downloads.bar.bg = "#${config.colorScheme.palette.base00}"
      c.colors.downloads.error.bg = "#${config.colorScheme.palette.base00}"
      c.colors.downloads.start.bg = "#${config.colorScheme.palette.base00}"
      c.colors.downloads.stop.bg = "#${config.colorScheme.palette.base00}"
      c.colors.downloads.error.fg = "#${config.colorScheme.palette.base08}"
      c.colors.downloads.start.fg = "#${config.colorScheme.palette.base0D}"
      c.colors.downloads.stop.fg = "#${config.colorScheme.palette.base0B}"
      c.colors.downloads.system.fg = "None"
      c.colors.downloads.system.bg = "none"

      c.colors.keyhint.bg = "#${config.colorScheme.palette.base01}"
      c.colors.keyhint.fg = "#${config.colorScheme.palette.base05}"
      c.colors.keyhint.suffix.fg = "#${config.colorScheme.palette.base0D}"

      c.colors.messages.error.bg = "#${config.colorScheme.palette.base02}"
      c.colors.messages.info.bg = "#${config.colorScheme.palette.base02}"
      c.colors.messages.warning.bg = "#${config.colorScheme.palette.base02}"
      c.colors.messages.error.border = "#${config.colorScheme.palette.base01}"
      c.colors.messages.info.border = "#${config.colorScheme.palette.base01}"
      c.colors.messages.warning.border = "#${config.colorScheme.palette.base01}"
      c.colors.messages.error.fg = "#${config.colorScheme.palette.base08}"
      c.colors.messages.info.fg = "#${config.colorScheme.palette.base05}"
      c.colors.messages.warning.fg = "#${config.colorScheme.palette.base09}"

      c.colors.prompts.bg = "#${config.colorScheme.palette.base01}"
      c.colors.prompts.border = "1px solid " + "#${config.colorScheme.palette.base02}"
      c.colors.prompts.fg = "#${config.colorScheme.palette.base05}"
      c.colors.prompts.selected.bg = "#${config.colorScheme.palette.base04}"
      c.colors.prompts.selected.fg = "#${config.colorScheme.palette.base06}"

      c.colors.statusbar.normal.bg = "#${config.colorScheme.palette.base00}"
      c.colors.statusbar.insert.bg = "#${config.colorScheme.palette.base03}"
      c.colors.statusbar.command.bg = "#${config.colorScheme.palette.base00}"
      c.colors.statusbar.caret.bg = "#${config.colorScheme.palette.base00}"
      c.colors.statusbar.caret.selection.bg = "#${config.colorScheme.palette.base00}"
      c.colors.statusbar.progress.bg = "#${config.colorScheme.palette.base00}"
      c.colors.statusbar.passthrough.bg = "#${config.colorScheme.palette.base00}"
      c.colors.statusbar.normal.fg = "#${config.colorScheme.palette.base05}"
      c.colors.statusbar.insert.fg = "#${config.colorScheme.palette.base06}"
      c.colors.statusbar.command.fg = "#${config.colorScheme.palette.base05}"
      c.colors.statusbar.passthrough.fg = "#${config.colorScheme.palette.base09}"
      c.colors.statusbar.caret.fg = "#${config.colorScheme.palette.base09}"
      c.colors.statusbar.caret.selection.fg = "#${config.colorScheme.palette.base09}"

      c.colors.statusbar.url.error.fg = "#${config.colorScheme.palette.base08}"
      c.colors.statusbar.url.fg = "#${config.colorScheme.palette.base05}"
      c.colors.statusbar.url.hover.fg = "#${config.colorScheme.palette.base0D}"
      c.colors.statusbar.url.success.http.fg = "#${config.colorScheme.palette.base0C}"

      c.colors.statusbar.url.success.https.fg = "#${config.colorScheme.palette.base0B}"
      c.colors.statusbar.url.warn.fg = "#${config.colorScheme.palette.base0A}"
      c.colors.statusbar.private.bg = "#${config.colorScheme.palette.base01}"
      c.colors.statusbar.private.fg = "#${config.colorScheme.palette.base0E}"
      c.colors.statusbar.command.private.bg = "#${config.colorScheme.palette.base00}"
      c.colors.statusbar.command.private.fg = "#${config.colorScheme.palette.base0E}"

      c.colors.tabs.bar.bg = "#${config.colorScheme.palette.base02}"
      c.colors.tabs.even.bg = "#${config.colorScheme.palette.base03}"
      c.colors.tabs.odd.bg = "#${config.colorScheme.palette.base04}"
      c.colors.tabs.even.fg = "#${config.colorScheme.palette.base0C}"
      c.colors.tabs.odd.fg = "#${config.colorScheme.palette.base0F}"
      c.colors.tabs.indicator.error = "#${config.colorScheme.palette.base08}"
      c.colors.tabs.indicator.system = "rgb"

      c.colors.tabs.selected.even.bg = "#${config.colorScheme.palette.base00}"
      c.colors.tabs.selected.odd.bg = "#${config.colorScheme.palette.base00}"
      c.colors.tabs.selected.even.fg = "#${config.colorScheme.palette.base05}"
      c.colors.tabs.selected.odd.fg = "#${config.colorScheme.palette.base05}"

      c.colors.contextmenu.menu.bg = "#${config.colorScheme.palette.base00}"
      c.colors.contextmenu.menu.fg = "#${config.colorScheme.palette.base05}"
      c.colors.contextmenu.disabled.bg = "#${config.colorScheme.palette.base01}"
      c.colors.contextmenu.disabled.fg = "#${config.colorScheme.palette.base08}"
      c.colors.contextmenu.selected.bg = "#${config.colorScheme.palette.base01}"
      c.colors.contextmenu.selected.fg = "#${config.colorScheme.palette.base06}"

      c.colors.webpage.bg = "#${config.colorScheme.palette.base00}"


      with config.pattern('*://*.i2p') as p:
        p.content.javascript.enabled = False
        p.content.pdfjs = False
        p.content.cookies.accept = "never"

      with config.pattern('*://*.onion') as p:
        p.content.javascript.enabled = False
        p.content.pdfjs = False
        p.content.cookies.accept = "never"
    '';
  };

}
