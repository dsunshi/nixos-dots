{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    stow
    gnumake
    git
  ];
}
