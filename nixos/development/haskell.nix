{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ghc
    ghcid
    cabal-install
    zlib
  ];
}
