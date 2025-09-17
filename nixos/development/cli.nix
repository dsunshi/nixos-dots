{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ghostty
    iosevka
    yazi
    bat
  ];
}
