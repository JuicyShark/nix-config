{ pkgs, ... }:
{
  # Import Files Specific to Homelab config
  imports = [
    ./common   # Global Home-Manager options
  ];
}
