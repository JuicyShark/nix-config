{config, ...}: {
  programs = {
    cava = {
      enable = true;
      settings = {
        general = {
          framerate = 120;
          autosens = 1;
          sesitivity = 115;
          bars = 0;
          bar_width = 3;
          bar_spacing = 0;
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
          gradient = 1;
          gradient_count = 4;
          # Requires extra set of string for config to read
          gradient_color_1 = "'#${config.colorScheme.palette.base0E}'";
          gradient_color_2 = "'#${config.colorScheme.palette.base0D}'";
          gradient_color_3 = "'#${config.colorScheme.palette.base0C}'";
          gradient_color_4 = "'#${config.colorScheme.palette.base0B}'";
        };

        smoothing = {
          noise_reduction = 45;
        };
      };
    };
  };
}
