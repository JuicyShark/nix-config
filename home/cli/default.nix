{  pkgs, ... }:
{
  imports = [
	  ./kitty.nix
    ./zsh
    ./nvim
    ./cava.nix
    ./yazi.nix
  ];
    home.packages = with pkgs; [
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
      config = {
        hwdec = "auto-safe";
        keep-open = "yes";
        cache = "yes";
        cache-secs = "300";
        demuxer-max-back-bytes = "20M";
        demuxer-max-bytes = "20M";
        gpu-context = "wayland";
        vo = "gpu";
        profile = "gpu-hq";
        osc = false;
        border = false;
      };
     # scripts = with pkgs.mpvScripts; [thumbnail sponsorblock mpris youtube-upnext mpv-notify-send];
    };
  };
}
