{ config, lib, pkgs, ... }:
{
  nixpkgs.config.nvidia.acceptLicense = true;
	environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

	hardware = {
  	opengl = {
    	enable = true;
    	driSupport = true;
    	driSupport32Bit = true;
    	extraPackages = with pkgs; [nvidia-vaapi-driver];
      setLdLibraryPath = true;
    };

    nvidia = {
      # Explicit Sync is here
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.42.02";
        sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
        sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        persistencedSha256 = lib.fakeSha256;
      };
    	modesetting.enable = true;
    	powerManagement.enable = false;
    	powerManagement.finegrained = false;
  		open = false;
  		nvidiaSettings = false;
  	  };
	};

  services.xserver.videoDrivers = ["nvidia"];

  environment.sessionVariables = {
		LIBVA_DRIVER_NAME = "nvidia";
	  GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
