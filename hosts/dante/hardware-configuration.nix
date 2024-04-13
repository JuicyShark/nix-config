{config, lib, modulesPath, ... }: 
{
	imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
	
	boot = {
		initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ata_piix" "usbhid" "sd_mod"];
		initrd.kernelModules = [ ];
		kernelModules = [ "kvm-intel" ];
		extraModulePackages = [ ];
		loader.grub.enable = true;
		loader.systemd-boot.enable = false;
		loader.grub.device = "/dev/sdc";
	};

	fileSystems."/" = 
		{
			device = "/dev/disk/by-uuid/44eae4ed-3200-4d5a-b3de-65bc6be3cbe8";
			fsType = "ext4";
		};
	fileSystems."/nextcloud" = 
		{
			device = "/dev/disk/by-uuid/e65aaaad-242e-4db6-89d9-6c7dd24fba88";
			fsType = "ext4";
		};
	fileSystems."/git" = 
		{
			device = "/dev/disk/by-uuid/bafbaa56-a615-4f4b-8743-a467c6916eb8";
			fsType = "ext4";
		};

	swapDevices = [ { device = "/dev/disk/by-uuid/e01b80cf-fac6-4c5c-a37c-408253c1203a"; } ];

  networking = {
    useDHCP = lib.mkDefault false;
    defaultGateway = "192.168.54.99";
    nameservers = [ "8.8.8.8" "8.8.4.4" "192.168.54.99"];
    interfaces = {
      "enp3s0" = {
        useDHCP = lib.mkDefault false;
        ipv4 = { 
          addresses = [
            {
              address = "192.168.54.60";
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

