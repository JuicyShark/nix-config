{ pkgs, lib, config, ...}: 
{
	options = {
		desktop.enable = lib.mkEnableOption "Enables desktop GUI Apps";
		homelab.enable = lib.mkEnableOption "Enable HomeLab Services";
		gaming.enable = lib.mkEnableOption "Enable Gaming apps";
	  cybersecurity.enable = lib.mkEnableOption "Enable Cyber Security CLI and Desktop Apps";	
	};
  
  imports = lib.flatten [
    ./hardware
    ./services
    ./programs
  ];
  config = lib.mkIf (config.desktop.enable) {
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

