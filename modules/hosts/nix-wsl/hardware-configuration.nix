{lib, ...}: {
  imports = [];

  boot.initrd.availableKernelModules = ["virtio_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/mnt/wsl" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/usr/lib/wsl/drivers" = {
    device = "none";
    fsType = "9p";
  };

  fileSystems."/lib/modules" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/lib/modules/5.15.146.1-microsoft-standard-WSL2" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0a80931e-c210-4263-9e93-5ef390f15f17";
    fsType = "ext4";
  };

  fileSystems."/mnt/wslg" = {
    device = "none";
    fsType = "tmpfs";
  };

  fileSystems."/mnt/wslg/distro" = {
    device = "none";
    fsType = "none";
    options = ["bind"];
  };

  fileSystems."/usr/lib/wsl/lib" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/mnt/wslg/doc" = {
    device = "none";
    fsType = "overlay";
  };

  fileSystems."/tmp/.X11-unix" = {
    device = "/mnt/wslg/.X11-unix";
    fsType = "none";
    options = ["bind"];
  };

  fileSystems."/mnt/c" = {
    device = "C:\134";
    fsType = "9p";
  };

  fileSystems."/mnt/g" = {
    device = "G:\134";
    fsType = "9p";
  };

  fileSystems."/mnt/p" = {
    device = "P:\134";
    fsType = "9p";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/8745ae76-e219-48a5-8ed6-2b14160a130d";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
