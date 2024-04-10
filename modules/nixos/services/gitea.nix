{lib, config, ...}:
{
	config = lib.mkIf config.homelab.enable {
		services.gitea = {
			enable = true;
			stateDir = "/git/state";
			customDir =  "/git";
			group = "gitea";
			user = "gitea";

		};
	

	};
}
