{ pkgs, ... }:
{
  nixpkgs.config.nvidia.acceptLicense = true;
	environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

	hardware = {
  	/*opengl = {
      enable = true;
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };*/

    nvidia = {
      # Explicit Sync is here
      package = pkgs.linuxKernel.packages.linux_zen.nvidia_x11_beta;
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
