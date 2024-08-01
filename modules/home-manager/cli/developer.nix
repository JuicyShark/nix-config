{
  config,
  pkgs,
  ...
}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      silent = true;
    };
    git = {
      enable = true;
      userEmail = "maxwellb9879@gmail.com";
      userName = "JuicyShark";
      extraConfig = {
        core.pager = "nvim -R";
        color.pager = "no";
      };
    };
    gitui.enable = true;
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
      enable = true;
      enableSshSupport = true;
      enableZshIntegration = true;
      enableExtraSocket = true;
      # enableBrowserSocket = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
