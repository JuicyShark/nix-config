{ pkgs, osConfig, sops, ... }:
{
	home.packages = with pkgs; [
		twitch-tui
		streamlink
	];
	xdg.configFile."twt/config.toml".text = ''
		[twitch]
		username = "juicedsos"
		channel = "brayorsum"
		# The IRC server to connect to.
		server = "irc.chat.twitch.tv"
		# token =

		[terminal]
		# The delay in milliseconds between terminal updates.
		tick_delay = 10
		# The maximum amount of messages that can be rendered.
		maximum_messages = 2000
		# The file to put logs in.
		log_file = ""
		# if verbose (debug) logging should be enabled.
		verbose = false
		# What state the application should start in.
		# Options: dashboard, normal, and help.
		first_state = "dashboard"

		[storage]
		# If previous channels switched to should be tracked.
		# If enabled, the channel switcher search the user's previously switched to channels.
		channels = true
		# If previous username mentions should be tracked.
		# If enabled, the chat input box will search previously mentioned users, given that
		# the first character in the input box is `@`.
		mentions = false

		[filters]
		# If filters should be enabled.
		# Filters can be configured by placing a `filters.txt` file in the same directory
		# as the config file.
		# Each new filter is to be put on a new line.
		# Regex can be used, where as keywords will also try to match anything in a message.
		enabled = false
		# If the regex filters should be reversed.
		# This means that everything in the filters file will be accepted.
		reversed = false
	
		[frontend]
		# If the time and date is to be shown in the chat window.
		show_datetimes = false
		# The format of string that will show up in the terminal.
		# Specification of formatting datetime strings can be found here: https://strftime.org/
		datetime_format = "%a %b %e %T %Y"
		# If usernames should be shown in the chat window.
		username_shown = true
		# The color palette for usernames.
		# Options: pastel, vibrant, warm, and cool.
		palette = "pastel"
		# Show the title values at the top of the terminal.
		title_shown = true
		# The amount of space between the chat window and the terminal border.
		margin = 0
		# Show twitch badges next to usernames.
		badges = true
		# Color theme, being either light or dark.
		theme = "dark"
		# If your username should be highlighted when it appears in chat.
		username_highlight = true
		# If there should be state tabs shown on the bottom of the terminal.
		state_tabs = true
		# The shape of the cursor in insert boxes.
		# Options: user (current terminal cursor), line, underscore, and block.
		cursor_shape = "user"
		# If the cursor should be blinking.
		blinking_cursor = false
		# If mouse scrolling should be inverted.
		inverted_scrolling = false
		# If scroll offset integer should be shown.
		show_scroll_offset = true
		# If Twitch emotes should be displayed (requires kitty terminal).
		twitch_emotes = true
		# If BetterTTV emotes should be displayed (requires kitty terminal).
		betterttv_emotes = true
		# If 7TV emotes should be displayed (requires kitty terminal).
		seventv_emotes = false
		# If FrankerFaceZ emotes should be displayed (requires kitty terminal).
		frankerfacez_emotes = false
		# Channel names to always be displayed in the start screen (dashboard).
		# Example: ["Xithrius", "RocketLeague", "AntVenom"]
		favorite_channels = []
		# The amount of recently connected to channels shown on the start screen.
		recent_channel_count = 5
		# What style the border of the terminal should have.
		# Options: plain, rounded, double, and thick.
		border_type = "rounded"
		# If the usernames should be aligned to the right.
		# They will be shown to the left if this is disabled.
		right_align_usernames = false
		# Do not display the window size warning.
		show_unsupported_screen_size = true	
	'';
	/*sops.secrets.twitch-token = {
		owner = "juicy";
		group = "root";
		mode = "0600";
	};*/
}
