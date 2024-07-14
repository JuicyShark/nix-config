{ pkgs, inputs, ... }:
{
  # Import Files Specific to Homelab config
  imports = [
 	./common   # Global Home-Manager options
  ./programs
      ];

  home.packages = with pkgs; [

  ];

}
