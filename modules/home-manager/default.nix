{
  lib,
  osConfig,
  ...
}: let
  desktopPackages = lib.optionals osConfig.desktop.enable [
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
