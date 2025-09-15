{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  environment.systemPackages = with pkgs; [
    neovim
    git # git is required for the plugin manager to function properly
    unzip # unzip is required for Mason LSP pacakages
    # External language servers:
    haskellPackages.haskell-language-server
    haskellPackages.haskell-debug-adapter
  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    lua-language-server
  ];
}
