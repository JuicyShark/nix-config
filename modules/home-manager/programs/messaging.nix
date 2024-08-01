{pkgs, ...}: {
  home.packages = with pkgs; [
    discordo # Terminal Discord
    (pkgs.discord.override {
      withVencord = true;
    })
    signal-desktop
  ];

  xdg.configFile."discordo/config.toml".text = ''
    mouse = true

    timestamps = false
    timestamps_before_author = false
    timestamps_format = "3:04PM"

    messages_limit = 50
    editor = "default"

    [keys]
    focus_guilds_tree = "Ctrl+G"
    focus_messages_text = "Ctrl+T"
    focus_message_input = "Ctrl+P"
    toggle_guild_tree = "Ctrl+B"
    select_previous = "Rune[k]"
    select_next = "Rune[j]"
    select_first = "Rune[g]"
    select_last = "Rune[G]"

    [keys.guilds_tree]
    select_current = "Enter"

    [keys.messages_text]
    select_reply = "Rune[s]"
    reply = "Rune[r]"
    reply_mention = "Rune[R]"
    delete = "Rune[d]"
    yank = "Rune[y]"
    open = "Rune[o]"

    [keys.message_input]
    send = "Enter"
    editor = "Ctrl+E"
    cancel = "Esc"

    [theme]
    border = false
    border_color = "default"
    border_padding = [0, 0, 1, 1]
    title_color = "default"
    background_color = "default"

    [theme.guilds_tree]
    auto_expand_folders = true
    graphics = true

    [theme.messages_text]
    author_color = "aqua"
    reply_indicator = "╭ "
  '';
}
