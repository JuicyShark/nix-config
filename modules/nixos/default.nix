{
  config,
  lib,
  ...
}: {
  imports = [
    ./services
    ./hyprland.nix
    ./gaming.nix
  ];
  /*
  ++ (
    # Options for Gui are defined under shared system confiruation
    if config.gui.backend == "wayland"
    then [
      ./hyprland.nix
    ]
    else if config.gui.backend == "x11"
    then [
      #TODO add gnome support
    ]
    else if config.gui.backend == "nix-wsl"
    then [
      #TODO add support for nix-wsl
    ]
    else [
    ]
  )
  ++ lib.mkOptional config.gui.gamingPC.enable [./gaming.nix];
  */
}
