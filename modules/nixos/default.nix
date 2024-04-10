{config, lib, ...}: 
{
	options = {
		desktop.enable = lib.mkEnableOption "Enables desktop GUI Apps";
		homelab.enable = lib.mkEnableOption "Enable HomeLab Services";
		gaming.enable = lib.mkEnableOption "Enable Gaming apps";
		
	};
	imports = lib.flatten [
			./hardware
			./programs
			./games
			./services
			./terminal	
	];
	
}

