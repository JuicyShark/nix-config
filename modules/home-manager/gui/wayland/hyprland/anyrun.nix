{inputs, config, pkgs, ... }:
{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
  	enable = true;
		config = {
			plugins = with inputs.anyrun.packages.${pkgs.system}; [
				applications
				shell
				symbols
				rink
				websearch
  		];
			
			x = { fraction = 0.5; };
			y = { fraction = 0.25; };
      width = { fraction = 0.2; };
      hidePluginInfo = true;
      showResultsImmediately = true;
      closeOnClick = true;
    };
  
		extraCss = ''
			* {
    		transition: 200ms ease;
				font-family: "${config.font}";
				font-size: 1.3rem;
				color: #${config.colorScheme.palette.base05};
  		}

			#window {
				background-color: transparent;
			}

			box#main {
				background-color: transparent;
				border: none;
			}
	
			entry#entry {
				min-height: 40px;
				border-radius: 15px;
				background: #${config.colorScheme.palette.base00};
				opacity: 0.85;
				box-shadow: none;
				border: 2px solid #${config.colorScheme.palette.base0D};
				margin-bottom: 10px;
			}
	
			list#main {
				background-color: #${config.colorScheme.palette.base00};
				opacity: 0.85;
				border: 2px solid #${config.colorScheme.palette.base0D};
				border-radius: 15px;
				padding: 10px;
			}

			#plugin {
				background: #${config.colorScheme.palette.base00};
				padding: 5px;
			}
	
			#match {
				padding: 3px;
			}

			#match:selected {
				background: #${config.colorScheme.palette.base03};
				border-radius: 15px;
				color: #${config.colorScheme.palette.base0E};
			}

			#match:hover {
				background: transparent;
				border-radius: 15px;
			}

			label#match-desc {
				font-size: 12pt;
				color: #${config.colorScheme.palette.base0E};
			}
		'';

		extraConfigFiles."applications.ron".text = ''
			Config(
				desktop_actions: false,
				max_entries: 5
			)
		'';
	
		extraConfigFiles."symbols.ron".text = ''
			Config(
				prefix: ":",
				symbols: {
    			"shrug": "¯\\_(ツ)_/¯"
				},
				max_entries: 3,
			)	
		'';
    	
		extraConfigFiles."shell.ron".text = ''
    	Config(
				prefix: ":sh",
				shell: zsh,
			)
		'';

  	extraConfigFiles."websearch.ron".text = ''
    	Config(
    		prefix: "?",
				engines: Google,
			)
    '';
	};
}
