{lib, config, ...}:
{
  config = lib.mkIf config.homelab.enable {
    users.groups.git = { };
    services.gitea = {
			enable = true;
			customDir =  "/git";
			group = "git";
      user = "gitea";

      settings.server = {
        SSH_PORT = 2033;
        HTTP_PORT = 8199;
      };

		};


	};
}
