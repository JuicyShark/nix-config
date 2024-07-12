{ lib, ...}:

{

		imports =  [
      #./nextcloud.nix
      #./adguard.nix
      #./media.nix
      #./gitea.nix
      #./redis.nix
      ./openssh.nix
      #./nfs.nix
      #./virtualisation.nix
		];
}
