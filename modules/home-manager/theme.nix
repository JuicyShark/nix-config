{
  pkgs,
  config,
  lib,
  ...
}: {
  home.sessionVariables.GTK_THEME = config.gtk.theme.name;
  home.file."pictures/wallpapers" = {
    source = ../backgrounds;
    recursive = true;
  };

  gtk = {
    enable = true;
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintmedium";
      gtk-xft-rgba = "rgb";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintmedium";
      gtk-xft-rgba = "rgb";
    };

    font = {
      name = config.font;
      size = 13;
    };

    theme = {
      name = lib.mkDefault "Catppuccin-Mocha-Compact-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "compact";
        tweaks = [];
        variant = "mocha";
      };
    };

    cursorTheme = {
      name = lib.mkDefault "Catppuccin-Mocha-Blue-Cursors";
      size = 32;
      package = lib.mkDefault pkgs.catppuccin-cursors.mochaBlue;
    };

    iconTheme = {
      name = lib.mkDefault "Papirus-Dark";
      package = lib.mkDefault pkgs.catppuccin-papirus-folders;
    };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.pointerCursor = {
    gtk.enable = false;
    package = config.gtk.cursorTheme.package;
    name = config.gtk.cursorTheme.name;
    size = config.gtk.cursorTheme.size;
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "gtk";
      package = pkgs.qt6.qtbase.override {
        # https://codereview.qt-project.org/c/qt/qtbase/+/547252
        patches = [./qtbase-gtk3-xdp.patch];
        qttranslations = null;
      };
    };
  };
  services.xsettingsd = {
    enable = true;
    settings = {
      #"Net/ThemeName" = "${config.gtk.theme.name}";
      "Net/IconThemeName" = "${config.gtk.iconTheme.name}";
    };
  };
}
