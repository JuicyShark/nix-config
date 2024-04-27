{ config, lib, pkgs, ... }: 
{
  config = lib.mkIf config.desktop.enable {
    sound.enable = true;
    security.rtkit.enable = true;
  	services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
   };
   environment.systemPackages = with pkgs; [
      pwvucontrol
   ];
  };
}
