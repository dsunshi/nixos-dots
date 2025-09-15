all: stow-home stow-nixos
	sudo nixos-rebuild switch

.PHONY: stow-home
stow-home:
	@cd home/ && stow --verbose --no-folding --target=$$HOME --restow . 2>&1 | grep -v "BUG in find_stowed_path"

.PHONY: stow-nixos
stow-nixos:
	@cd nixos/ && sudo stow --verbose --no-folding --target=/etc/nixos --restow . 2>&1 | grep -v "BUG in find_stowed_path"
