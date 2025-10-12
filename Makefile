all: stow-home 

.PHONY: stow-home
stow-home:
	stow --verbose --no-folding --target=$$HOME --restow . 2>&1 | grep -v "BUG in find_stowed_path"

