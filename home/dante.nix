{ pkgs, inputs, ... }:
{
  # Import Files Specific to Homelab config
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./common   # Global Home-Manager options
  ];

  home.packages = with pkgs; [
    parrot      # Discord Bot
  ];

  home.persistence."/persist/home" = {
    directories = [
      "tmp"
      "documents"
      ".gnupg"
      ".ssh"
    ];
    allowOther = true;
  };
}
