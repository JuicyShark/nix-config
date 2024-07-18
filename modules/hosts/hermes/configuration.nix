# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:
{
	imports = [
    ../../home-manager/users/juicy/juicy.nix
    #../../home-manager/users/jake/jake.nix
	  ../shared-configuration.nix
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [  bluez bluez-tools ];

  hardware = {
    bluetooth.enable = true;
      raspberry-pi = {
        config = {
          all = {
            base-dt-params = {
              krnbt = {
                enable = true;
                value = "on";
              };
            };
          };
        };
      };
    };
    security.polkit.enable = true;
}
