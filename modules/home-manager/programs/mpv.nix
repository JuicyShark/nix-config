{pkgs, ... }: 
{
  home.packages = with pkgs; [
    playerctl
  ];
  
  programs = {
    mpv ={
      enable = true;
      bindings = {
        UP = "add volume +2";
        DOWN = "add volume -2";
      };
      # https://wiki.archlinux.org/title/mpv#Hardware_video_acceleration
      config = {
        hwdec = "auto-safe";
        gpu-context = "wayland";
        vo = "gpu";
        profile = "gpu-hq";
        osc = false;
        border = false;
      };
    scripts = with pkgs.mpvScripts; [mpris thumbnail sponsorblock];
    };
    imv.enable = true;
  };
}
