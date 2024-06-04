{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    vaultwarden
  ];
}
