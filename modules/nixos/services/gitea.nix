{lib, config, ...}:
{
  config = lib.mkIf config.services.gitea.enable {
    users.groups.git = { };
    services.gitea = {
			customDir =  "/persist/chomp/git";
			group = "git";
      user = "gitea";

      settings.server = {
        SSH_PORT = 2033;
        HTTP_PORT = 8199;
      };
		};
	};
}
