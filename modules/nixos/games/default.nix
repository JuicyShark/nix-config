{config, lib, pkgs, ... }:
{	

	config = lib.mkIf config.gaming.enable {
		programs.steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
		};
		environment.systemPackages = with pkgs; [
			runelite
			steam
		];
	};
}
