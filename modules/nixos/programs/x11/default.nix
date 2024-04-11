{ config, lib, pkgs, ... }: 

{
	
		imports = [
		./i3
  ];

  services = {
    xserver.enable = true;
    xserver.excludePackages = [ pkgs.xterm ];
  };

}
