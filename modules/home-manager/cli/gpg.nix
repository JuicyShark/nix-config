{pkgs, config, ...}:
{
  programs = {
    gh = {
      enable = true;
      extensions = with pkgs; [gh-markdown-preview];
      settings = {
        version = "1";
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
    keychain = {
      enable = true;
      enableZshIntegration = true;
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
    # TODO setup gpg keys and gbg agent
    gpg-agent = {
      enable = false;
      enableSshSupport = true;
      enableZshIntegration = true;
      enableExtraSocket = true;
     # enableBrowserSocket = true;
      #pinentryPackage = pkgs.pinentry-curses;
    };
  };

  home.persistence = {
    "/persist${config.home.homeDirectory}".files = [
      ".keys/ssh/known_hosts"
      ".config/gh/hosts.yml"


    ];
  };
}
