{config, osConfig, lib, pkgs, ...}:

{
    home.packages = with pkgs; [
      vscode-with-extensions
      wezterm
      rofi
      jq
      inotify-tools
      xdotool
      xclip
      gpick
      feh
      playerctl
      polkit_gnome
    ];
  home.file = {
    "awesome" = {
      source = ../awesomewm;
      target = "./.config/awesome";
    };
    "lock" = {
      target = "./.local/bin/lock";
      text = ''
        #!/bin/zsh
        playerctl pause
        sleep 0.2
        awesome-client "awesome.emit_signal('toggle::lock')"
      '';
    };
  };

    xsession.windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-git;
      luaModules = with pkgs.luaPackages; [
        lgi
        ldbus
        luadbi-mysql
        luaposix
        lua-pam
      ];
    };
}
