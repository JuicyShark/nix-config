{ ... }:
{
  programs.navi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      cheats = {
        paths = [
          "~/Documents/cheats"
        ];
      };
    };
  };
}
