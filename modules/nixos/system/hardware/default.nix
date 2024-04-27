{ config, lib, ... }:

{
	options = {
		hardware.nvidia.enable = lib.mkEnableOption "Enable NVIDIA driver support.";
		hardware.nvidia.legacyEnable = lib.mkEnableOption "Enable Legacy Drivers";
	};

	

	imports =  [
		./nvidia.nix
		./legacy_nvidia_overrides.nix
	];
}
