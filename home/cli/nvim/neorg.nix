{ inputs, config, ...}:
{
  programs.nixvim.plugins.neorg = {
    enable = true;
	  modules = {
		  "core.defaults" = {
			  __empty = null;
		  };
	    "core.completion" = {
			  config = {
				  engine = "nvim-cmp";
			  };
		  };
		  "core.dirman" = {
			  config = {
				  workspaces = {
            home = "${config.xdg.userDirs.documents}/notes";
            nixosConfig = "${config.xdg.userDirs.documents}/nixos";
            publicNotes = "${config.xdg.userDirs.documents}/share";
				  };
				  default_workspace = "home";
			    index = "index.norg";
				  use_popup = "true";
			  };
		  };
		  "core.journal" = {
			  config = {
			  	journal_folder = "journal";
			  	strategy = "nested";
			  };
		  };
		  "core.concealer" = {
		  	config = {
		  		folds = true;
		  		icon_preset = "varied";
		  		init_open_folds = "auto";
		  	};
		  };
	  };
  };
}
