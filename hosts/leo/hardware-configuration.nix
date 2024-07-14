{ inputs, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.default
    ./disko.nix
  ];


  boot = {
    kernel.sysctl."vm.swappiness" = 10;
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
      kernelParams = [
        "intel_pstate=active"
        "module_blacklist=i915"
        "intel_iommu=on"
        "nouveau.modeset=0"
        "processor.max_cstate=1"
      ];
    supportedFilesystems = [ "ntfs" "btrfs"];
    loader = {
      systemd-boot.enable = true;
	    efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
      /*boot.initrd.postDeviceCommands = lib.mkAfter ''
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
      ''; */
    };
  };

  networking = {
    hostName = "leo";
    wireguard.interfaces.wg0 = {
      ips = [ "10.100.0.2/24" ];
      peers = [
          /*{ example of forwdinv everbthing to peer endpoint
            publicKey = "oPUTwZApzM5gFsV4+i2HwP6gESWS+9/9497jo2JjflM=";
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "192.168.54.99:51820";
            persistentKeepalive = 25;
          }*/
        ];
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
  hardware.cpu.intel.updateMicrocode = true;
}
