{ config, lib, pkgs, ... }:
{
	config = lib.mkIf config.hardware.nvidia.enable {
  		nixpkgs.config.nvidia.acceptLicense = true;
  		boot.initrd.kernelModules =  [ "nvidia" ];
	#	boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  # Enable OpenGL
	hardware = {
  		opengl = {
    			enable = true;
    			driSupport = true;
    			driSupport32Bit = true;
    			extraPackages = with pkgs; [
        			vaapiVdpau
        			libvdpau-va-gl
      			];
      			extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      			setLdLibraryPath = true;
  			};

	  
		nvidia = {
    			modesetting.enable = true;
    			powerManagement.enable = false;
    			powerManagement.finegrained = false;
    			open = false;
    			nvidiaSettings = true;
  		};
	};

	# Load nvidia driver for Xorg and Wayland
	services.xserver.videoDrivers = ["nvidia"]; 
	environment.systemPackages = with pkgs; [
		libva-utils
		nvidia-vaapi-driver
	];

	environment.sessionVariables = {
		LIBVA_DRIVER_NAME = "nvidia";
		GBM_BACKEND = "nvidia-drm";
    		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		WLR_NO_HARDWARE_CURSORS = "1";
		QT_WAYLAND_FORCE_DPI= "physical";
		QT_WAYLAND_DISABLE_WINDOWDECORATION= "1";
		_JAVA_AWT_WM_NONREPARENTING= "1";
		NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";
	};
	};
}
