{ inputs, config, ...}:
let
	# Hack to fix broken unstable Neorg plugin
	pkgs-stable = inputs.nixpkgs-stable.legacyPackages."x86_64-linux";
in
{
  programs.nixvim.plugins.neorg = {
    enable = true;
    package = pkgs-stable.vimPlugins.neorg; #TODO switch back to unstable when Neorg breaking changes fixed
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
