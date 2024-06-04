{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true; 
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-nvfbc
      obs-studio-plugins.input-overlay
      obs-studio-plugins.obs-gstreamer
      obs-studio-plugins.obs-vkcapture
    ];
  };
}
