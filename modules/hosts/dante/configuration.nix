{
  pkgs,
  ...
}: {
  imports = [
    ../../home-manager/users/juicy/juicy.nix
    #../../home-manager/users/jake/jake.nix
    ../../nixos/optin-persistence.nix
    ../../nixos/nvidia.nix
    ../shared-system-configuration.nix
    ./hardware-configuration.nix
  ];

  config = {
    nvidiaLegacy.enable = true;
    desktop.enable = false;

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
