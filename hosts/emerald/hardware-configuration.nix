{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot = {
      kernelPackages = pkgs.linuxkernel.packages.linux_zen;
      kernelParams = [
        # Activate Performance state
        "intel_pstate=active"
        "i915.fastboot=1"
      ];
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [ ];

      initrd = {
        availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
        kernelModules = [ ];
      };

      loader = {
        systemd-boot.enable = true;
        efi.cantouchEfiVariables = true;
      };
    };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/27e1c866-d71c-4ecb-b2b6-a79b306a73ce";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E425-ED48";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  hardware.xpadneo.enable = true;         # optional; xbox gamepad firmware
  hardware.bluetooth.enable = true;       # optional; Bluetooth support

  networking = {
    hostname = "emerald";
    wireguard.interfaces.wg0 = {
      ips = [ "10.100.0.3/24" ];
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
        useDHCP = lib.mkDefault false;
        ipv4 = {
          addresses = [
            {
              address = "192.168.54.56";
              prefixLength = 24;
            }
          ];
        };
      };
      wlo1.useDHCP = lib.mkDefault true;
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
