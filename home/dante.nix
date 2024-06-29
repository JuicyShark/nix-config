{ ... }:
{
  # Import Files Specific to Homelab config
  imports = [
    ./common   # Global Home-Manager options
  ];

  home.packages = with pkgs; [
    parrot      # Discord Bot
  ];
}
