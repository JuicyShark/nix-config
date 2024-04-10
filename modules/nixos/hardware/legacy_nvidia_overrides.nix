{config, pkgs, lib, ... }:

{
	config = lib.mkIf (config.hardware.nvidia.enable && config.hardware.nvidia.legacyEnable) {
		hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
		boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11_legacy470 ];
	};
}
