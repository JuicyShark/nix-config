{  pkgs, ... }: 
{
	imports = [
	  ./kitty.nix
    ./foot.nix
    ./zsh
    ./nvim
  ];
  home.packages = with pkgs; [
    #Pretty Fluff
    peaclock
    cmatrix
    pipes
    cava

    #Utilities 
    ffmpeg
    glfw
    speedtest-cli
    yt-dlp
    
    rustscan
    ffsend
    gitui
  ];
}
