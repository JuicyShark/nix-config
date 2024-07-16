{ pkgs, inputs, ... }:
{
  # Import Files Specific to Homelab config
  imports = [

  ];

  home.packages = with pkgs; [
    parrot      # Discord Bot
  ];

}
