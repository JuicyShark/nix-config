{ pkgs, ... }:

{
	imports =  [
    ./hyprland
    ./waybar
    ./mako.nix
    ./anyrun.nix
  ];
  
  xdg.mimeApps.enable = true;

	home.packages = with pkgs; [
		wl-clipboard
		wl-mirror
    wlr-randr
    wf-recorder
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
  };
}
