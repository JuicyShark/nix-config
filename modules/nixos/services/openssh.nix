{config, lib, ... }:

{
  config = lib.mkIf (config.services.openssh.enable) {
    services.openssh = {
      #knownHosts.leo.certAuthority = true;
      hostKeys = [
        {
          bits = 4096;
          path = "/etc/keys/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          path = "/etc/keys/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
      ports = [2033];
      openFirewall = true;

      settings = {
        PermitRootLogin = "prohibit-password";
      };
    };

    programs = {
      ssh = {
        startAgent = true;
      };
    };

    users.users.${config.main-user}.openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMsJd6JmEQtQ1er5vuTA3Frz2JBcgndpPcQlhjK7xcY"
      ];
    };
  };
}
