{config, outputs, lib, pkgs, ... }:
 let
  hosts = lib.attrNames outputs.nixosConfigurations;

  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist
  hasOptinPersistence = config.environment.persistence ? "/persist/system";
in
{
  config = lib.mkIf (config.services.openssh.enable) {
    services.openssh = {
      settings = {
        # Automatically remove stale sockets
        StreamLocalBindUnlink = "yes";
        # Allow forwarding ports to everywhere
        GatewayPorts = "clientspecified";
        # Let WAYLAND_DISPLAY be forwarded
        AcceptEnv = "WAYLAND_DISPLAY";
      };
      #knownHosts.leo.certAuthority = true;
      hostKeys = [
        {
          path = "${lib.optionalString hasOptinPersistence "/persist/system"}/etc/ssh/ssh_host_ed25519_key";
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
        knownHosts = lib.genAttrs hosts (hostname: {
          publicKeyFile = ../../../hosts/${hostname}/ssh_host_ed25519_key.pub;
          extraHostNames = [
            "${hostname}"
          ] ++  (lib.optional (hostname == config.networking.hostName) "localhost");
        });
      };
    };

    users.users.${config.main-user}.openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMsJd6JmEQtQ1er5vuTA3Frz2JBcgndpPcQlhjK7xcY"
      ];
    };

    # Passwordless sudo when SSH'ing with keys
    security.pam.services.sudo = {config, ...}: {
      rules.auth.rssh = {
        order = config.rules.auth.ssh_agent_auth.order - 1;
        control = "sufficient";
        modulePath = "${pkgs.pam_rssh}/lib/libpam_rssh.so";
        settings.authorized_keys_command =
          pkgs.writeShellScript "get-authorized-keys"
          ''
            cat "/etc/ssh/authorized_keys.d/$1"
          '';
      };
    };
    # Keep SSH_AUTH_SOCK when sudo'ing
    security.sudo.extraConfig = ''
      Defaults env_keep+=SSH_AUTH_SOCK
    '';
  };
}
