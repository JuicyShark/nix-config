{ config, lib, pkgs, ... }:

{

programs.ncmpcpp = {
    enable = true;
    settings = {
      mpd_host = "::";
      mpd_port = "6600";
    };
  };
}
