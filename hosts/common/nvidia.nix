{ pkgs, config, lib, ... }:
{

  options.nvidiaLegacy = lib.mkOption {
  type = lib.types.bool;
  default = false;
  };

  config = {
  nixpkgs.config.nvidia.acceptLicense = true;

	environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    nvtopPackages.nvidia
  ];

	hardware = {
      nvidia = {
      # Explicit Sync is here
      package = (if config.nvidiaLegacy then config.boot.kernelPackages.nvidiaPackages.legacy_470 else pkgs.linuxKernel.packages.linux_zen.nvidia_x11_beta);
      modesetting.enable = true;
    	powerManagement.enable = false;
    	powerManagement.finegrained = false;
  		open = false;
  		nvidiaSettings = false;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
	};

  services.xserver.videoDrivers = ["nvidia"];
  
  boot.extraModulePackages = [ (if config.nvidiaLegacy then config.boot.kernelPackages.nvidia_x11_legacy470 else config.boot.kernelPackages.nvidia_x11_beta) ];
  environment.sessionVariables = {
		LIBVA_DRIVER_NAME = "nvidia";
	  GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
};
}
