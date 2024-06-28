{ pkgs, ... }:
{
	programs.git = {
		enable = true;
		userName = "JuicyShark";
		userEmail = "maxwellb9879@gmail.com";
		extraConfig = {

		/*	credential.helper = "${
				pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret"; */

		};
	};
	
	programs.gh = {
		enable = true;
		settings.editor = "nvim";
	};
	home.packages = with pkgs; [
		lazygit
	];
}
