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
}
