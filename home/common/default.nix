{ osConfig, ... }:

{
  imports = [
    ./shared-configuration.nix
  ] ++ (if osConfig.programs.hyprland.enable then [
    ../window-manager/wayland/hyprland
    ./theme.nix
  ] else if osConfig.services.xserver.enable then [
    ../window-manager/x11/gnome
    ./theme.nix
  ] else [ ]);
}
