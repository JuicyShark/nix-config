{config, lib, ... }:

{
  config = lib.mkIf config.homelab.enable {
    services.samba = {
      enable = true;
      securityType = "user";
      openFirewall = true; 
      shares = {
        documents = {
          path = "/home/juicy/documents";
          browseable = "yes";
          "read only" = false;
          "guest ok" = "no";
        };
        git = {
          path = "/git";
          browseable = "yes";
        };
      };
    };

    services.samba-wsdd ={
      enable = true;
      openFirewall = true;
      discovery = true;
      hostname = "Nix-FileServer";
   };



    networking.firewall.enable = true;
    networking.firewall.allowPing = true;
  };
}
