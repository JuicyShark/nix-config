{config, lib, ... }:

{
  config = lib.mkIf config.homelab.enable {
    services.samba = {
      enable = true;
      securityType = "user";
      openFirewall = true; 
      shares = {
        documents = {
          path = "/srv/documents";
          browseable = "yes";
          writable = "yes";
          "read only" = false;
          "guest ok" = "yes";
        };
        git = {
          path = "/srv/git";
          browseable = "yes";
          writable = "yes";
          "read only" = false;
          "guest ok" = "yes";
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
