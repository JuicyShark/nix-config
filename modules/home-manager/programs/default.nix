{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./obs.nix
    #./neo4j.nix
    #./cyberSec-packages.nix
    ./qutebrowser
    ./music.nix
    ./messaging.nix
    ./foot.nix
    ./kitty.nix
  ];
  home.packages = with pkgs; [
    rustc
    cargo
    rustycli
  ];
}
