# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot = {
      kernelpackages = pkgs.linuxkernel.packages.linux_zen;
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [ ];

      initrd = {
        availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
        kernelModules = [ ];
      };

      loader = {
        systemd-boot.enable = true;
        efi.cantouchefivariables = true;
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


  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.

  networking = {
    useDHCP = lib.mkDefault false;
    defaultGateway = "192.168.54.99";
    nameservers = [ "8.8.8.8" "8.8.4.4" "192.168.54.99" ];
    interfaces = {
      enp3s0 = {
        useDHCP = lib.mkDefault false;
        ipv4 = {
          addresses = [
            {
              address = "192.168.54.59";
              prefixLength = 24;
            }
          ];
        };
      };
    };
  };
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
