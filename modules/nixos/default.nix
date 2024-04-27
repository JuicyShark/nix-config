{ pkgs, lib, ...}: 
{
	options = {
		desktop.enable = lib.mkEnableOption "Enables desktop GUI Apps";
		homelab.enable = lib.mkEnableOption "Enable HomeLab Services";
		gaming.enable = lib.mkEnableOption "Enable Gaming apps";
		
	};
  
  imports = lib.flatten [
    ./hardware
    ./services
    ./programs
  ];
  config = {
    security.polkit.enable = true;
    systemd = {
      user.services.polkit-gnome-autentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
       };
      };
    };
  };	
}

