{ pkgs, inputs, ... }:
{
  # Import files specific to Juicy User Config
  imports = [
    ./common     # Import Globals
   	./programs
  ];
# Daemon to manage secret (private) keys independently from any protocol
programs.gpg.enable = true;
services.gpg-agent = {
  enable = true;
  enableSshSupport = true;
  enableZshIntegration = true;
  pinentryPackage = pkgs.pinentry-gtk2;
};
  # Packages Specific to Juicy User
  home.packages = with pkgs; [
    bambu-studio
    moonlight-qt
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    inputs.nix-gaming.packages.${pkgs.system}.rocket-league
    inputs.nix-gaming.packages.${pkgs.system}.technic-launcher
  ];

}
