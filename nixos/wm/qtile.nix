{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    rofi
  ];

  services.xserver.windowManager.qtile.enable = true;
}

