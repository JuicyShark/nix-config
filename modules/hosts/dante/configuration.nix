{ pkgs, inputs, ... }:
{
  imports = [
    ../../users/juicy/juicy.nix
    #../../users/jake/jake.nix
    	../../modules/nix/optin-persistence.nix
	../shared-configuration.nix
    ../../modules/nvidia.nix
    ./hardware-configuration.nix
    
  ];

  config = {
	  nvidiaLegacy.enable = true;

    programs = {
      fuse.userAllowOther = true;
    };

    services = {
      openssh.enable = true;
      gitea.enable = true;
      jellyfin.enable = true;
      nfs.server.enable = true;
      mopidy = {
        enable = true;
        extensionPackages = with pkgs; [
          mopidy-tidal
          mopidy-mpd
        ];
      };
    };


    security.polkit.enable = true;
    networking.hostName = "dante";
  };
}
