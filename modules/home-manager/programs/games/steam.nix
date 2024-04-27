{ pkgs, lib, ... }: let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        gamescope
        mangohud
      ];
  };

  
  steam-session = let
    gamescope = lib.concatStringsSep " " [
      (lib.getExe pkgs.gamescope)
      "--output-width 3440"
      "--output-height 1440"
      "--framerate-limit 120"
      "--prefer-output DP-1"
      "--expose-wayland"
      "--steam"
    ];
    steam = lib.concatStringsSep " " [
      "steam"
      "steam://open/bigpicture"
    ];
  in
    pkgs.writeTextDir "share/wayland-sessions/steam-sesson.desktop"
  
    /*ini*/''
      [Desktop Entry]
      Name=Steam Session
      Exec=${gamescope} -- ${steam}
      Type=Application
    '';
in {
  home.packages = with pkgs; [
    steam-with-pkgs
    steam-session
    gamescope
    mangohud
    protontricks
  ];
}
