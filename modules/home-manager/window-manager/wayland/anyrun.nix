{
  inputs,
  config,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  colour = config.stylix.base16Scheme; #lib.stylix.colors.withHashtag;
in {
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://pass.nixlab.au";
      email = "maxwellb9879@gmail.com";
      pinentry = pkgs.pinentry-gnome3;
    };
  };

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

      x = {fraction = 0.5;};
      y = {fraction = 0.25;};
      width = {fraction = 0.2;};
      hidePluginInfo = true;
      showResultsImmediately = true;
      hideIcons = false;
      closeOnClick = true;
      maxEntries = 20;
    };

    extraCss = ''
      * {
       	transition: 200ms ease;
      	font-family: "${config.stylix.fonts.sansSerif.name}";
      	font-size: 1.75rem;
      	color: #${colour.base05};
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
      	background: ${colour.base00};
      	opacity: 0.85;
      	box-shadow: none;
      	border: 2px solid ${colour.base0D};
      	margin-bottom: 10px;
      }

      list#main {
      	background-color: ${colour.base00};
      	opacity: 0.85;
      	border: 2px solid ${colour.base0D};
      	border-radius: 15px;
      	padding: 10px;
      }

      #plugin {
      	background: ${colour.base00};
      	padding: 5px;
      }

      #match {
      	padding: 3px;
      }

      #match:selected {
      	background: ${colour.base03};
      	border-radius: 15px;
      	color: ${colour.base0E};
      }
      #match-title {
        font-size: 16pt;
        font-family: ${config.stylix.fonts.serif.name};
      }
      #match-title:selected {
        color: ${colour.base08};
      }
      #match-desc {
      	font-size: 1pt;
        font-family: ${config.stylix.fonts.monospace.name};
        color: ${colour.base04};
      }
    '';

    extraConfigFiles."applications.ron".text = ''
      Config(
      	desktop_actions: false,
        max_entries: 5,
        terminal: Some("kitty"),
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

    extraConfigFiles."nixos-options.ron".text = let
      nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
      hm-options = inputs.home-manager.packages.${pkgs.system}.docs-json + "/share/doc/home-manager/options.json";
      options = builtins.toJSON {
        ":nix" = [nixos-options];
        ":hm" = [hm-options];
      };
    in ''
      Config(
          // add your option paths
          options: ${options},
          max_entries: Some(7)
       )
    '';
  };
}
