{ config, lib, pkgs, ... }:
{
	config = lib.mkIf config.hardware.nvidia.enable {
    	nixpkgs.config.nvidia.acceptLicense = true;
  		
	  hardware = {
  		opengl = {
    		enable = true;
    		driSupport = true;
    		driSupport32Bit = true;
    		extraPackages = with pkgs; [nvidia-vaapi-driver];
      		setLdLibraryPath = true;
      	};

	nvidia = {
    		modesetting.enable = true;
    		powerManagement.enable = true;
    		powerManagement.finegrained = false;
  			open = false;
  			nvidiaSettings = false;
  	  	};
	  };
	  services.xserver.videoDrivers = ["nvidia"]; 
	  environment.systemPackages = with pkgs; [
      		vulkan-loader
      		vulkan-validation-layers
      		vulkan-tools
		jellyfin-mpv-shim
	  ];

	  environment.sessionVariables = {
		  LIBVA_DRIVER_NAME = "nvidia";
	  	GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
	  	WLR_NO_HARDWARE_CURSORS = "1";
  	};
	};
}
