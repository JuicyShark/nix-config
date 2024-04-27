{ config, lib, modulesPath, ... }:

{
	imports =[ (modulesPath + "/installer/scan/not-detected.nix") ];

	boot = {
		initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
			kernelModules = [ ];
			systemd.enable = true;
		};
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			timeout = 15;
		};
		kernelModules = [ "kvm-intel" ];
		extraModulePackages = [ ];
	};

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/3477ccc0-d78d-4c40-b004-7296b7b77566";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EE13-42AC";
      fsType = "vfat";

    };
    fileSystems."/mnt/git" = {
      device = "192.168.54.60:/git";
      fsType = "nfs";
  };

  fileSystems."/games" = 
  {  device = "/dev/disk/by-uuid/BAEC3099EC3051BD";
     fsType = "lowntfs-3g";
     options = [ "uid=1000" "gid=100" "exec" "rw" "permissions" "juicy" "auto" "ignore_case" ];
  };
 fileSystems."/home/juicy/documents" = 
  {  device = "/dev/disk/by-uuid/68249C47249C1A60";
     fsType = "ntfs";
     options = [ "uid=1000" "gid=100" "exec" "rw" "permissions" "juicy" "auto" ];
  };
  #  swapDevices = [ ];


  
  networking = {
    useDHCP = lib.mkDefault false;
    defaultGateway = "192.168.54.99";
    nameservers = [ "8.8.8.8" "8.8.4.4" "192.168.54.99"];
    interfaces = {
      "enp5s0" = {
        useDHCP = lib.mkDefault false;
          ipv4 = { 
            addresses = [
              {
                address = "192.168.54.54";
                prefixLength = 24;
              }
            ];
          };
        };
      };
    };
  
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
