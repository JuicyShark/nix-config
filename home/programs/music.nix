{ config, lib, pkgs, ... }:

{
  # TODO setup TIDAL auth with sops secrets
  # https://github.com/tehkillerbee/mopidy-tidal
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-tidal
      mopidy-mpris
      mopidy-notify
    ];
    settings = {
      follow_symlinks = true;
      media_dirs = [
        "$XDG_MUSIC_DIR|Music"
      ];
    };
  };
}
