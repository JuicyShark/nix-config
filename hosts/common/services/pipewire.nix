{ pkgs, inputs, ... }:
{

  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  
  services.pipewire = {
    enable = true;  
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    lowLatency.enable = true;
  };

    # make pipewire realtime-capable
  security.rtkit.enable = true;
    
  environment.systemPackages = with pkgs; [
    pwvucontrol
  ];
}
