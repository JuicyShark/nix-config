{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.virtualisation.libvirtd.enable) {
    virtualisation = {
      waydroid.enable = true;
      libvirtd = {
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      /*podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
        };*/
      spiceUSBRedirection.enable = true;
    };

    programs.virt-manager.enable = true;
    environment.systemPackages = with pkgs; [
#podman-tui
      spice
        spice-gtk
        spice-protocol
        virt-viewer
    ];


 services.neo4j = {
      enable = true;
      bolt = {
        enable = true;
        tlsLevel = "DISABLED";
        listenAddress = "127.0.0.1:7687";
      };
      http = {
        enable = true;
        listenAddress = "127.0.0.1:7474";
      };
      https.enable = false;
    };
    systemd.services.neo4j.wantedBy = lib.mkForce [];
  };
}
