{ pkgs, ... }:
{
	programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    userName = "JuicyShark";
		userEmail = "maxwellb9879@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";

      merge.conflictStyle = "zdiff3";
      commit.verbose = true;
      diff.algorithm = "histogram";
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";
      # Automatically track remote branch
      push.autoSetupRemote = true;
      # Reuse merge conflict fixes when rebasing
      rerere.enabled = true;
    };
    lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
    ];
	};

	programs.gh = {
		enable = true;
		settings.editor = "nvim";
	};
	home.packages = with pkgs; [
		lazygit
	];
}
