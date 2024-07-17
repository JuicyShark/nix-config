{config, osConfig, lib, pkgs, ... }:
{

  imports = [
    ./zsh
    ./nvim
    ./yazi.nix
    ./git.nix
    ./bottom.nix
    ./eza.nix
    ./fastfetch.nix
    ./starship.nix
    ./direnv.nix
    ./git.nix
    ./gpg.nix
    ./man.nix
  ];

  config = {

    programs.nushell = {
      enable = false;
      shellAliases = {
        cd = "z";
        ls = "${pkgs.eza}/bin/eza --group-directories-first -a --colour=always --icons=always";
        tree = "${pkgs.eza}/bin/eza --tree --icons=always --colour=always";
        cat = "${pkgs.bat}/bin/bat";
        btop = "${pkgs.bottom}/bin/btm";
        nixconfig = "nvim ${config.xdg.userDirs.documents}/nixos-config";
        notes = "nvim -c 'Neorg index'";
        journal = "nvim -c 'Neorg journal today'";
        grep = "${pkgs.ripgrep}/bin/rg";
        dante = "ssh ${osConfig.main-user}@192.168.54.60 -p 2033";
        jake = "ssh ${osConfig.main-user}@192.168.54.59 -p 2033";
        juicy = "ssh ${osConfig.main-user}@192.168.54.54 -p 2033";
        hermes = "ssh ${osConfig.main-user}@192.168.54.56 -p 2033";
      };
      configFile.text = ''
        # let's define some colors
        let base00 = "${config.colorScheme.palette.base00}"
        let base01 = "${config.colorScheme.palette.base02}"
        let base02 = "${config.colorScheme.palette.base03}"
        let base03 = "${config.colorScheme.palette.base04}"
        let base04 = "${config.colorScheme.palette.base01}"
        let base05 = "${config.colorScheme.palette.base05}"
        let base06 = "${config.colorScheme.palette.base06}"
        let base07 = "${config.colorScheme.palette.base07}"
        let base08 = "${config.colorScheme.palette.base08}"
        let base09 = "${config.colorScheme.palette.base09}"
        let base0a = "${config.colorScheme.palette.base0A}"
        let base0b = "${config.colorScheme.palette.base0B}"
        let base0c = "${config.colorScheme.palette.base0E}"
        let base0d = "${config.colorScheme.palette.base0D}"
        let base0e = "${config.colorScheme.palette.base0C}"
        let base0f = "${config.colorScheme.palette.base0F}"

# we're creating a theme here that uses the colors we defined above.

let base16_theme = {
    separator: $base03
    leading_trailing_space_bg: $base04
    header: $base0b
    date: $base0e
    filesize: $base0d
    row_index: $base0c
    bool: $base08
    int: $base0b
    duration: $base08
    range: $base08
    float: $base08
    string: $base04
    nothing: $base08
    binary: $base08
    cellpath: $base08
    hints: dark_gray

    # shape_garbage: { fg: $base07 bg: $base08 attr: b} # base16 white on red
    # but i like the regular white on red for parse errors
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_bool: $base0d
    shape_int: { fg: $base0e attr: b}
    shape_float: { fg: $base0e attr: b}
    shape_range: { fg: $base0a attr: b}
    shape_internalcall: { fg: $base0c attr: b}
    shape_external: $base0c
    shape_externalarg: { fg: $base0b attr: b}
    shape_literal: $base0d
    shape_operator: $base0a
    shape_signature: { fg: $base0b attr: b}
    shape_string: $base0b
    shape_filepath: $base0d
    shape_globpattern: { fg: $base0d attr: b}
    shape_variable: $base0e
    shape_flag: { fg: $base0d attr: b}
    shape_custom: {attr: b}
}

# now let's apply our regular config settings but also apply the "color_config:" theme that we specified above.

let config = {
        filesize_metric: true
        show_banner: false
  table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  use_ls_colors: true
  color_config: $base16_theme # <-- this is the theme
  use_grid_icons: true
  footer_mode: always #always, never, number_of_rows, auto
  animate_prompt: false
  float_precision: 2
  use_ansi_coloring: true
  filesize_format: "b" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
  edit_mode: emacs # vi
  max_history_size: 10000
  log_level: error
}
      '';
    };


    home.packages = with pkgs; [
      #Utilities
      glfw
      speedtest-cli
      trippy # Network diagnostics
      viddy # Modern Watch command
      so #stackoverflow search
      circumflex # HackerNews in the terminal

      dig # check dns list
      rustscan
      ffsend
      gitui

      gcc       # C compiler
		  /* nix tools */
		  manix  # Nix pkg and options search


    ] ++ (if osConfig.raspberryDev.enable then [
      # Raspberry Pi
    nrfconnect
      nrf5-sdk
      #nrfutil
      nrf-command-line-tools
      rpi-imager
      rpiboot
      segger-jlink
      coreboot-toolchain.arm
      /* Raspberry Pico */
      pioasm
		  pico-sdk
		  picotool
      minicom

      # openthread Border Router
      #nrfutil
      nrf5-sdk
      nrfconnect
      nrf-command-line-tools
    ] else [

    ]);


  programs = {
    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        dialect = "uk";
        update_check = false;
        auto_sync = true;
        sync_frequency = "15m";
        sync.records = true;
        filter_mode_shell_up_key_binding = "directory";
        style = "compact";
        inline_height = 50;
       # daemon = {
        #  enable = true;
        #  systemd_socket = true;
       # };
      };
    };
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };

  };


};
}
