{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  hardware = {
    keyboard.zsa.enable = true;
    logitech.wireless.enable = true;
  };

  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
	    efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
      boot.initrd.postDeviceCommands = lib.mkAfter ''
        mkdir /btrfs_tmp
        mount /dev/root_vg/root /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
    };
  };

  /*
  fileSystems."/persistent" = {
    device = "/dev/root_vg/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = [ "subvol=persistent" ];
  };

  fileSystems."/nix" = {
    device = "/dev/root_vg/root";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };
  */

  ##old
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
