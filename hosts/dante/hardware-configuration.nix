{ config, lib, modulesPath, inputs, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.default
    ./disko.nix
  ];

  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "ehci_pci" "ata_piix" "usb_storage" "usbhid" "sd_mod" ];
    kernelModules = [ ];
    postDeviceCommands = lib.mkAfter ''
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


  networking = {
    useDHCP = lib.mkDefault false;
    defaultGateway = "192.168.54.99";
    nameservers = [ "192.168.54.99" ];
    hostName = "dante";
    wireguard.interfaces.wg0 = {
      ips = [ "10.100.0.4/24" ];
      peers = [
          /*{ example of forwdinv everbthing to peer endpoint
            publicKey = "oPUTwZApzM5gFsV4+i2HwP6gESWS+9/9497jo2JjflM=";
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "192.168.54.99:51820";
            persistentKeepalive = 25;
          }*/
      ];
    };
    interfaces = {
      enp3s0 = {
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
