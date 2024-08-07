{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ata_piix" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = false;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0df5eaec-7501-4f8a-aea0-9f9cd0363659";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  fileSystems."/srv" = {
    device = "/dev/disk/by-uuid/db66a620-60fd-428d-860c-cf8ea79da555";
    fsType = "btrfs";
  };

  fileSystems."/torrent" = {
    device = "/dev/disk/by-uuid/b0057ba5-6421-412a-b0e4-81c4866de341";
    fsType = "btrfs";
  };

  swapDevices = [];

  networking = {
    hostName = "hermes";
    interfaces = {
      enp5s0 = {
        useDHCP = lib.mkDefault false;
        ipv4 = {
          addresses = [
            {
              address = "192.168.54.55";
              prefixLength = 24;
            }
          ];
        };
      };
      wlan0.useDHCP = true;
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
