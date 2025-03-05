# Default configuration file for tmux-powerline.
# Modeline {
#	 vi: foldmarker={,} foldmethod=marker foldlevel=0 tabstop=4 filetype=sh
# }

# General {
	# Show which segment fails and its exit code.
	export TMUX_POWERLINE_DEBUG_MODE_ENABLED="false"
	# Use patched font symbols.
	export TMUX_POWERLINE_PATCHED_FONT_IN_USE="true"

	# The theme to use.
	export TMUX_POWERLINE_THEME="jofla"
	# Overlay directory to look for themes. There you can put your own themes outside the repo. Fallback will still be the "themes" directory in the repo.
	export TMUX_POWERLINE_DIR_USER_THEMES="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/themes"
	# Overlay directory to look for segments. There you can put your own segments outside the repo. Fallback will still be the "segments" directory in the repo.
	export TMUX_POWERLINE_DIR_USER_SEGMENTS="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/segments"

	# The initial visibility of the status bar. Can be {"on", "off", "2"}. 2 will create two status lines: one for the window list and one with status bar segments. 
	export TMUX_POWERLINE_STATUS_VISIBILITY="on"
	# In case of visibility = 2, where to display window status and where left/right status bars.
	# 0: window status top, left/right status bottom; 1: window status bottom, left/right status top
	export TMUX_POWERLINE_WINDOW_STATUS_LINE=0
	# The status bar refresh interval in seconds.
	# Note that events that force-refresh the status bar (such as window renaming) will ignore this.
	export TMUX_POWERLINE_STATUS_INTERVAL="1"
	# The location of the window list. Can be {"absolute-centre, centre, left, right"}.
	# Note that "absolute-centre" is only supported on `tmux -V` >= 3.2.
	export TMUX_POWERLINE_STATUS_JUSTIFICATION="centre"

	# The maximum length of the left status bar.
	export TMUX_POWERLINE_STATUS_LEFT_LENGTH="60"
	# The maximum length of the right status bar.
	export TMUX_POWERLINE_STATUS_RIGHT_LENGTH="90"

	# The separator to use between windows on the status bar.
	export TMUX_POWERLINE_WINDOW_STATUS_SEPARATOR=""

	# Uncomment these if you want to enable tmux bindings for muting (hiding) one of the status bars.
	# E.g. this example binding would mute the left status bar when pressing <prefix> followed by Ctrl-[
	#export TMUX_POWERLINE_MUTE_LEFT_KEYBINDING="C-["
	#export TMUX_POWERLINE_MUTE_RIGHT_KEYBINDING="C-]"
# }

# battery.sh {
	# How to display battery remaining. Can be {percentage, cute, hearts}.
	export TMUX_POWERLINE_SEG_BATTERY_TYPE="percentage"
	# How may hearts to show if cute indicators are used.
	export TMUX_POWERLINE_SEG_BATTERY_NUM_HEARTS="5"
# }

# date.sh {
	# date(1) format for the date. If you don't, for some reason, like ISO 8601 format you might want to have "%D" or "%m/%d/%Y".
	export TMUX_POWERLINE_SEG_DATE_FORMAT="%d/%m/%Y"
# }

# github_notifications.sh {
	# Github token (https://github.com/settings/tokens) with at least "notifications" scope
	export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_TOKEN=""
	# Include available notification reasons (https://docs.github.com/en/rest/activity/notifications?apiVersion=2022-11-28#about-notification-reasons),
	# in the format "REASON:SEPARATOR"
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_REASONS="approval_requested:-󰴄 |assign:-󰎔 |author:-󰔗 |comment:- |ci_activity:-󰙨 |invitation:- |manual:-󱥃 |mention:- |review_requested:- |security_alert:-󰒃 |state_change:-󱇯 |subscribed:- |team_mention:- "
	# Or if you don't like so many symbols, try the abbreviation variant
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_REASONS="approval_requested:areq|assign:as|author:au|comment:co|ci_activity:ci|invitation:in|manual:ma|mention:me|review_requested:rreq|security_alert:sec|state_change:st|subscribed:sub|team_mention:team"
	# Use symbol mode (ignored if you set TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_REASONS yourself)
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_SYMBOL_MODE="yes"
	# Summarize all notifications
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_SUMMARIZE="no"
	# Hide if no notifications
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_HIDE_NO_NOTIFICATIONS="yes"
	# Only show new notifications since date (default: today) (takes up to UPDATE_INTERVAL time to take effect)
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_SINCE="$(date +%Y-%m-%dT00:00:00Z)"
	# Enable show only notifications since date (takes up to UPDATE_INTERVAL time to take effect)
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_SINCE_ENABLE="no"
	# Maximum notifications to retreive per page (upstream github default per_page, 50)
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_PER_PAGE="50"
	# Maximum pages to retreive
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_MAX_PAGES="10"
	# Update interval to pull latest state from github api
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_UPDATE_INTERVAL="60"
	# Enable Test Mode (to test how the segment will look like when you have notifications for all types/reasons)
	# export TMUX_POWERLINE_SEG_GITHUB_NOTIFICATIONS_TEST_MODE="no"
# }

# hostname.sh {
	# Use short or long format for the hostname. Can be {"short, long"}.
	export TMUX_POWERLINE_SEG_HOSTNAME_FORMAT="long"
# }

# ifstat.sh {
	# Symbol for Download.
	# export TMUX_POWERLINE_SEG_IFSTAT_DOWN_SYMBOL="⇊"
	# Symbol for Upload.
	# export TMUX_POWERLINE_SEG_IFSTAT_UP_SYMBOL="⇈"
	# Symbol for Ethernet.
	# export TMUX_POWERLINE_SEG_IFSTAT_ETHERNET_SYMBOL="󰈀"
	# Symbol for WLAN.
	# export TMUX_POWERLINE_SEG_IFSTAT_WLAN_SYMBOL="󱚻"
	# Symbol for WWAN.
	# export TMUX_POWERLINE_SEG_IFSTAT_WWAN_SYMBOL=""
	# Separator for Interfaces.
	# export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_SEPARATOR=" | "
	# Space separated list of interface names to be excluded. substring match, regexp can be used.
	# Examples:
	# export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_EXCLUDES="tun" # will exclude 'tun0', 'utun0', 'itun', 'tun08127387'
	# export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_EXCLUDES="tun0 tuntun" # will exclude 'tun0', 'utun0', 'tuntun'
	# export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_EXCLUDES="^tun0$ ^tun1$" # excludes exactly 'tun0' and 'tun1'
	# Default:
	# export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE_EXCLUDES="^u?tun[0-9]+$"
# }

# lan_ip.sh {
	# Symbol for LAN IP.
	# export TMUX_POWERLINE_SEG_LAN_IP_SYMBOL="ⓛ "
	# Symbol colour for LAN IP
	# export TMUX_POWERLINE_SEG_LAN_IP_SYMBOL_COLOUR="255"
# }

# macos_notification_count.sh {

# }

# now_playing.sh {
	# Music player to use. Can be any of {audacious, banshee, cmus, apple_music, itunes, lastfm, plexamp, mocp, mpd, mpd_simple, pithos, playerctl, rdio, rhythmbox, spotify, spotify_wine, file}.
	export TMUX_POWERLINE_SEG_NOW_PLAYING_MUSIC_PLAYER="spotify"
	# File to be read in case the song is being read from a file
	export TMUX_POWERLINE_SEG_NOW_PLAYING_FILE_NAME=""
	# Maximum output length.
	export TMUX_POWERLINE_SEG_NOW_PLAYING_MAX_LEN="40"
	# How to handle too long strings. Can be {trim, roll}.
	export TMUX_POWERLINE_SEG_NOW_PLAYING_TRIM_METHOD="trim"
	# Characters per second to roll if rolling trim method is used.
	export TMUX_POWERLINE_SEG_NOW_PLAYING_ROLL_SPEED="2"
	# Mode of roll text {"space", "repeat"}. space: fill up with empty space; repeat: repeat text from beginning
	# export TMUX_POWERLINE_SEG_NOW_PLAYING_ROLL_MODE="repeat"
	# Separator for "repeat" roll mode
	# export TMUX_POWERLINE_SEG_NOW_PLAYING_ROLL_SEPARATOR="   "
	# If set to 'true', 'yes', 'on' or '1', played tracks will be logged to a file.
	# export TMUX_POWERLINE_SEG_NOW_PLAYING_TRACK_LOG_ENABLE="false"
	# If enabled, log played tracks to the following file:
	# export TMUX_POWERLINE_SEG_NOW_PLAYING_TRACK_LOG_FILEPATH="/Users/joflaherty/.now_playing.log"
	# Maximum number of logged song entries. Set to "unlimited" for unlimited entries.
	# export TMUX_POWERLINE_SEG_NOW_PLAYING_TRACK_LOG_MAX_ENTRIES="100"
# }

# time.sh {
	# date(1) format for the time. Americans might want to have "%I:%M %p".
	export TMUX_POWERLINE_SEG_TIME_FORMAT="%H:%M"
	# Change this to display a different timezone than the system default.
	# Use TZ Identifier like "America/Los_Angeles"
	# export TMUX_POWERLINE_SEG_TIME_TZ=""
# }

# tmux_mem_cpu_load.sh {
	# Arguments passed to tmux-mem-cpu-load.
	# See https://github.com/thewtex/tmux-mem-cpu-load for all available options.
	# export TMUX_POWERLINE_SEG_TMUX_MEM_CPU_LOAD_ARGS="-v"
# }

# tmux_session_info.sh {
	# Session info format to feed into the command: tmux display-message -p
	# For example, if FORMAT is '[ #S ]', the command is: tmux display-message -p '[ #S ]'
	export TMUX_POWERLINE_SEG_TMUX_SESSION_INFO_FORMAT="#S"
# }

# utc_time.sh {
	# date(1) format for the UTC time.
	export TMUX_POWERLINE_SEG_UTC_TIME_FORMAT="%H:%M %Z"
# }

# vpn.sh {
	# Mode for VPN segment {"both", "ip", "name"}. both: Show NIC/IP; ip: Show only IP; name: Show only NIC name
	# export TMUX_POWERLINE_SEG_VPN_DISPLAY_MODE="both"
	# Space separated list of tunnel interface names. First match is being used. substring match, regexp can be used.
	# Examples:
	# export TMUX_POWERLINE_SEG_VPN_NICS="tun" # will match 'tun0', 'utun0', 'itun', 'tun08127387'
	# export TMUX_POWERLINE_SEG_VPN_NICS="tun0 tuntun" # will match 'tun0', 'utun0', 'tuntun'
	# export TMUX_POWERLINE_SEG_VPN_NICS="^tun0$ ^tun1$" # exactly 'tun0' and 'tun1'
	# Default:
	# export TMUX_POWERLINE_SEG_VPN_NICS='^u?tun[0-9]+$'
	# Symbol to use for vpn tunnel.
	# export TMUX_POWERLINE_SEG_VPN_SYMBOL="󱠾 "
	# Colour for vpn tunnel symbol
	# export TMUX_POWERLINE_SEG_VPN_SYMBOL_COLOUR="255"
	# Symbol for separator
	# export TMUX_POWERLINE_SEG_VPN_DISPLAY_SEPARATOR="󰿟"
# }

# wan_ip.sh { Symbol for WAN IP
	# export TMUX_POWERLINE_SEG_WAN_IP_SYMBOL="ⓦ "
	# Symbol colour for WAN IP
	# export TMUX_POWERLINE_SEG_WAN_IP_SYMBOL_COLOUR="255"
# }

