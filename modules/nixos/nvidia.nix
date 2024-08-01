{
  pkgs,
  config,
  lib,
  ...
}: {
  options.nvidiaLegacy.enable = lib.mkEnableOption "Enable Legacy 470 nvidia driver";

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
        package =
          if config.nvidiaLegacy.enable
          then config.boot.kernelPackages.nvidiaPackages.legacy_470
          else config.boot.kernelPackages.nvidiaPackages.beta;
        modesetting.enable = true;
        nvidiaPersistenced =
          if config.homelab.enable
          then true
          else false;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
        open = lib.mkDefault true;
        nvidiaSettings = false;
      };

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];

    boot.extraModulePackages = [
      (
        if config.nvidiaLegacy.enable
        then config.boot.kernelPackages.nvidia_x11_legacy470
        else config.boot.kernelPackages.nvidiaPackages.beta
      )
    ];
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
