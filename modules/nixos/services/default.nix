{...}: {
  imports = [
    ./nextcloud.nix
    ./media.nix
    ./gitea.nix
    ./openssh.nix
    ./nfs.nix
    ./virtualisation.nix
    ./home-assistant.nix
  ];
}
