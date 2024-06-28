# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{

	imports = [
    ../shared-configuration.nix
    ../common/users/juicy
    ../common/nvidia.nix
		./hardware-configuration.nix
  ];  

  options.main-user = lib.mkOption {
    type = lib.types.str;
    default = "juicy";
  };
  
  config = {
	  # Enable Custom flags for Module selection
	  homelab.enable = true;
    cybersecurity.enable = true;
	  nvidiaLegacy.enable = true;

    networking.hostName = "dante";
  };
}
