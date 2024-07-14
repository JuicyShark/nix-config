{ config, lib, ... }:
{
  config = lib.mkIf config.services.nfs.server.enable {

    services.nfs.server = {
      lockdPort = 4001;
      mountdPort = 4002;
      statdPort = 4000;
      exports = ''
        /persist/chonk 192.168.54.54(rw,fsid=0,no_subtree_check)
      '';
    };
    networking.firewall = {
      enable = true;
      # for NFSv3; view with `rpcinfo -p`
      allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
      allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
    };
  };
}
