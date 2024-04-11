{ lib, config, ... }:

{
  config = lib.mkIf config.desktop.enable {
    programs.hyprland.enable = true;
  };
}
