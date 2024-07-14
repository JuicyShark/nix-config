{ config, pkgs, inputs, lib, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
	imports = [
    ../common/shared-configuration.nix
    ../common/nvidia.nix
    ./hardware-configuration.nix
   # inputs.impermanence.nixosModule
  ];

  config = {
	  nvidiaLegacy.enable = true;

    programs = {

    };
    services = {
      openssh.enable = true;
    };
    hardware = {

    };
    services.mopidy = {
      enable = true;
      extensionPackages = with pkgs; [
        mopidy-tidal
        mopidy-mpd
      ];
    };
    security.polkit.enable = true;

  networking.hostName = "dante";


  programs.fuse.userAllowOther = true;
  };
}
