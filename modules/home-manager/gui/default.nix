{ config, lib, ... }:

{
  imports = [
    ./firefox.nix
    ./themes.nix
  ];
 #  ++ lib.optional (config.environment.systemPackages.use_wayland_wm == "1") ./x11
  # ++ lib.optional (config.environment.systemPackages.use_x11_wm == "1") ./wayland;
}
