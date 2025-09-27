 # required packages
  - stow
  - neovim 0.12+
  - ghcup
  - ghostty

## Required packages for CachyOS
```bash
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
sudo pacman -S base-devel
makepkg -si
cd ..
rm -rf yay-bin

sudo pacman -S stow
sudo pacman -S neovim-nightly-bin
sudo pacman -S cachyos-gaming-meta

yay -S gchup-hs-bin

sudo pacman -S extra/ghostty
```
