{ ... }:
{
  imports = [
    ./common.nix
   	./programs
    ./development
    ./window-manager/wayland/hyprland
    #./window-manager/wayland/river
    #./window-manager/x11/awesomewm
  ];


}
