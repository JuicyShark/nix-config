{ config, ... }:
{
  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = false;
    extraConfig = ''
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
      c.colors.downloads.system.fg = "none"
      c.colors.downloads.system.bg = "none"


      c.colors.hints.bg = "#${config.colorScheme.palette.base09}"
      c.colors.hints.fg = "#${config.colorScheme.palette.base01}"
      c.hints.border = "1px solid " + "${config.colorScheme.palette.base01}"
      c.colors.hints.match.fg = "#${config.colorScheme.palette.base0D}"
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
      c.colors.webpage.darkmode.enabled = True
      c.colors.webpage.darkmode.policy.images = "never"
      c.colors.webpage.preferred_color_scheme = "dark"

      c.completion.cmd_history_max_items = 250
      c.completion.height = "28%"
      c.completion.use_best_match = True

      c.content.fullscreen.window = True

      c.content.notifications.presenter = "libnotify"
      c.content.pdfjs = True

      c.downloads.location.directory = "~/tmp"
      c.downloads.location.prompt = False

      c.editor.command = ["nvim", "{file}", "--cmd", "normal {line}G{column0}l"]
      c.fileselect.folder.command = ["kitty", "yazi", "{}"]

      c.fonts.web.size.default = 18
      c.fonts.web.size.default_fixed = 14
      c.fonts.web.size.minimum = 6
      c.fonts.web.size.minimum_logical = 8

      c.hints.auto_follow = "always"
      c.hints.chars = "arstneio"
      c.hints.find_implementation = "javascript"

      c.new_instance_open_target = "window"

      c.scrolling.bar = "never"
      c.scrolling.smooth = True

      c.spellcheck.languages = ["en-AU"]

      c.tabs.tabs_are_windows = True
      c.tabs.show = "never"

      c.statusbar.widgets = ["keypress", "url", "search_match", "scroll", "progress"]

      c.url.default_page = "https://www.google.com"
      c.url.start_pages = [ "https://www.google.com", "https://www.youtube.com", "https://www.facebook.com", "https://www.reddit.com" ]
      c.url.searchengines = {"DEFAULT": "https://google.com/search?q={}"}

      c.window.hide_decoration = True
      c.window.title_format = "{current_title}"
      c.window.transparent = True






  '';
  };
}
