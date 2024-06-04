{ lib, ...}:

{
options = {
		homelab.enable = lib.mkEnableOption "Enable HomeLab Services";
	  cybersecurity.enable = lib.mkEnableOption "Enable Cyber Security CLI and Desktop Apps";
	};
		imports =  [
      #./nextcloud.nix
      #./adguard.nix
      #./media.nix
      #./gitea.nix
      #./redis.nix
      ./pipewire.nix
      ./openssh.nix
      #./nfs.nix
      #./virtualisation.nix
		];
}
