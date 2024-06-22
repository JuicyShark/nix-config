{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    supportedFilesystems = [ "ntfs" ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
    };

    loader = {
      systemd-boot.enable = true;
	    efi.canTouchEfiVariables = true;
    };
};

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7985db3f-8429-4051-a25a-0f5ebdcf45c5";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EE13-42AC";
    fsType = "vfat";
  };
  fileSystems."/games" = {
    device = "/dev/disk/by-uuid/BAEC3099EC3051BD";
    fsType = "lowntfs-3g";
    options = [ "uid=1000" "gid=100" "exec" "rw" "permissions" "juicy" "auto" "ignore_case" ];
  };
  swapDevices = [ { device = "/dev/disk/by-uuid/cb625649-165e-4b56-8fc3-681e34e58c16"; } ];

  programs.nm-applet.enable = true;
  networking = {
    useDHCP = lib.mkDefault false;
    defaultGateway = "192.168.54.99";
    nameservers = ["192.168.54.99"];
    networkmanager = {
      enable = true;

    };
    interfaces."enp5s0".ipv4 = {
      addresses = [
        {
          address = "192.168.54.54";
          prefixLength = 24;
        }
      ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
