{ ... }:
{
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 120;
        autosens = 1;
        sesitivity = 150;
        bars = 0;
        bar_width = 15;
        bar_spacing = 2;
        sleep_timer = 380;
      };
      input = {
        method = "pipewire";
        source = "auto";
        channels = "stereo";
      };
      color = {
        background = "default";
        foreground = "default";
      };
      smoothing = {
        noise_reduction = 45;
      };
    };
  };
}
