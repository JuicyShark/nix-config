{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.services.gitea.enable {
    users.groups.git = {};
    services.gitea = {
      customDir = "/persist/chonk/git";
      group = "root";
      user = "root";

      settings.server = {
        SSH_PORT = 2033;
        HTTP_PORT = 8199;
      };
    };
  };
}
