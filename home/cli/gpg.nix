{pkgs, config, ...}:
{
  programs = {
    keychain = {
      enable = true;
      enableNushellIntegration = true;
      enableXsessionIntegration = false;

    };
    gpg = {
      enable = true;
      homedir = "${config.home.homeDirectory}/.keys/gnupg";
    };
    ssh = {
      addKeysToAgent = true;
      forwardAgent = true;
    };
  };
  services = {
    ssh-agent = {
      enable = true;
    };
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableNushellIntegration = true;
     # enableSSHSupport = true;
     # enableExtraSocket = true;
     # enableBrowserSocket = true;
      #pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
