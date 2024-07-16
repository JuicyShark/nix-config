{ ... }:

{
  imports = [
    <nixos-wsl/modules>
    ../shared-configuration.nix
    ./hardware-configuration.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "juicy";

  networking.hostName = "nix-wsl";

}
