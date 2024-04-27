{  pkgs, ... }: 
{
	imports = [
	  ./kitty.nix
    ./foot.nix
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
  
    rustscan
    ffsend
    gitui
  ];
}
