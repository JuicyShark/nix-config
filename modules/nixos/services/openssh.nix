{
  config,
  outputs,
  lib,
  pkgs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist
  #hasOptinPersistence = config.environment.persistence ? "/persist/system";
in {
  config = {
    services.openssh = {
      enable = true;
      settings = {
        StreamLocalBindUnlink = "yes";
        GatewayPorts = "clientspecified";
        AcceptEnv = "WAYLAND_DISPLAY";
      };
      hostKeys = [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
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
          extraHostNames =
            [
              "${hostname}"
            ]
            ++ (lib.optional (hostname == config.networking.hostName) "localhost");
        });
      };
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
