{
  lib,
  osConfig,
  ...
}: let
  desktopPackages = lib.optionals osConfig.gui.enable [
    ./programs
    ./services
    ./window-manager/wayland/hyprland
    ./theme.nix
  ];
in {
  imports =
    [
      ./cli
    ]
    ++ desktopPackages;
}
