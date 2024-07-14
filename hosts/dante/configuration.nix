{ pkgs, inputs, ... }:
{
  imports = [
    ../../users/juicy/juicy.nix
    #../../users/jake/jake.nix
    ../shared-configuration.nix
    ../nvidia.nix
    ./hardware-configuration.nix
    inputs.impermanence.nixosModule
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
