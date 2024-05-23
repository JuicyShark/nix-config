{ pkgs, inputs, neorg-overlay, ... }:

{

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "12y6mvmhzilibwrzlsdnhsmb8cipk9iwwib2m406kyajjaqq6iw6";
    }))
   # neorg-overlay.overlays.default
  ];

  hardware.nvidia.enable = true;
	desktop.enable = true;
  gaming.enable = true;
  cyberSec.enable = true;

	imports = [
	  ../shared-configuration.nix
		./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    ntfs3g
    wally-cli
    keymapviz
    libusb #zsa moonlander
    cmake
    udis86
  ];
	programs.hyprland.enable = true;

 home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      jake = import ../../modules/home-manager/jake.nix;
    };
  };
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [

    ];
    loader = {
	    systemd-boot.enable = true;
	    efi.canTouchEfiVariables = true;
    };
  };

	services.greetd = {
		enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome Jake' --cmd Hyprland";
        user = "jake";
      };
    };
  };


  networking.hostName = "emerald";

  # Probably better place to put these
  services.printing.enable = true;
  hardware = {
    bluetooth.enable = true;
    keyboard.zsa.enable = true;
    logitech.wireless.enable = true;
  };

  networking = {
    useDHCP = true;
    defaultGateway = "192.168.54.99";
    nameservers = ["192.168.54.99"];
    interfaces = {
      "enp3s0" = {
        useDHCP = true;
          ipv4 = {
            addresses = [
              {
                address = "192.168.54.69";
                prefixLength = 24;
              }
            ];
          };
        };
      };
  };
}
