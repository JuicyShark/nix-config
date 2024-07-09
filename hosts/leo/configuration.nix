{ pkgs, inputs, lib, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

nixpkgs.config = {
    overlays = [
      (self: super: {
        stdenv = super.stdenv.override {
          buildInputs = super.stdenv.buildInputs ++ [ super.gcc ];
          shellHook = ''
            export CFLAGS="-march=native -O2"
            export CXXFLAGS="-march=native -O2"
          '' + (super.stdenv.shellHook or "");
        };
      })
    ];
  };

  # TODO  set PI to remote build ARM
  nix.sshServe = {
    enable = false;
    write = true;
  };

  cybersecurity.enable = true;

    environment.systemPackages = with pkgs; [
      wally-cli   # Flash zsa Keyboard
      keymapviz   # Zsa Oryx dep
      rpi-imager  # Raspberry Pi Imaging Utilit1
    ];

    programs = {
      hyprland.enable = true;
    };

    services = {
      udev.extraRules = ''
        ACTION=="add|change", KERNEL=="nvme[a-z]", ATTR{queue/scheduler}="mq-deadline"
      '';
      mopidy = {
        enable = true;
        extensionPackages = with pkgs; [
          mopidy-tidal
          mopidy-mpd
        ];
      };
  };

  hardware = {
    keyboard.zsa.enable = true;
    bluetooth.enable = true;
    #logitech.wireless.enable = true;
  };
     # nvidia.enable = true;
    users.users.${config.main-user} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.password.path;
      shell = pkgs.nushell;
      description = config.main-user;
      extraGroups = [ "wheel" "juicy" ]
      ++ ifTheyExist [
        "minecraft"
        "network"
        "wireshark"
        "mysql"
        "media"
        "git"
        "libvirtd"
        "deluge"
        "nextcloud"
        "networkmanager"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaHQ2CZkI0ApcMHZzqNcU7fiTl/prML3ONJ3KrSmy4I"
      ];
      packages = [pkgs.home-manager];
    };

/* systemd.services.hdparm-enable-writeback = {
    description = "Enable Write-Back Cache on Disks";
    after = [ "local-fs.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.nvme-cli}/bin/nvme set-feature /dev/nvme0n1 -f 0x0c -v=1";# "${pkgs.nvme-cli}/bin/nvme set-feature /dev/nvme1n1 -f 0x0c -v=1" ];
    };
    #  ExecStart = "${pkgs.hdparm}/bin/hdparm -W1 /dev/nvme1n1p4";
     # && ${pkgs.hdparm}/bin/hdparm -W1 /dev/nvme0n1p1";

    }; */

  imports = [
    ./hardware-configuration.nix
    ../common/gaming.nix
    ../common/nvidia.nix
    ../common/shared-configuration.nix
  ];
}
