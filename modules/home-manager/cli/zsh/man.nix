{ pkgs, ... }:
{
  programs = {
    man = {
      enable = true;
      generateCaches = true;
    };
    navi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        cheats = {
          paths = [
            "~/documents/cheatsheets"
          ];
        };
      };
    };
    tealdeer = {
      enable = true;
      updates = {
        auto_update = true;
        auto_update_interval_hours = 128;
      };
    };
  };
  manual.manpages.enable = true;

}
