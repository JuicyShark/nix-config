{ lib, ... }:

{
  services.openssh = {
   # knownHosts.leo.certAuthority = true;
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

      enable = true;
      ports = [2033];
      openFirewall = true;
      settings = {
        PermitRootLogin = "prohibit-password";
      };
    };
    programs.ssh = {
      startAgent = true;

    };

    security.pam.sshAgentAuth.enable = true;
}
