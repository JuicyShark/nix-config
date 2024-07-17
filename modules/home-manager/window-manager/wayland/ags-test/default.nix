{ osConfig, lib, config, inputs, pkgs, ... }:
let
  colour = config.colorScheme.palette;
  hasOptinPersistence = osConfig.environment.persistence ? "/persist/home";
in
  {
    imports = [
      inputs.ags.homeManagerModules.default
    ];

    programs.ags = {
      enable = true;
      configDir = (if osConfig.hardware.keyboard.zsa.enable then ../ags-test else ../ags-jake);
      extraPackages = with pkgs; [
        accountsservice
        gnome.gnome-bluetooth
      ];
    };

  home.file.".config/theme.css".text = ''
    @define-color base   #${colour.base00};
    @define-color base-transparent alpha(#${colour.base00}, 0.8);
    @define-color mantle  #${colour.base01};
    @define-color mantle-transparent alpha(#${colour.base01}, 0.5);
    @define-color surface0 #${colour.base02};
    @define-color surface1 #${colour.base03};
    @define-color surface2 #${colour.base04};
    @define-color text     #${colour.base05};
    @define-color blue      #${colour.base0D};
    @define-color lavender  #${colour.base07};
    @define-color teal      #${colour.base0C};
    @define-color green     #${colour.base0B};
    @define-color yellow    #${colour.base0A};
    @define-color peach     #${colour.base09};
    @define-color red       #${colour.base08};
    @define-color mauve     #${colour.base0E};
    @define-color flamingo  #${colour.base0F};
    @define-color rosewater #${colour.base06};
  '';
 /*   home.persistence."/persist/home/${config.home.username}".files = [
      ".config/theme.css"
    ]; */
}
