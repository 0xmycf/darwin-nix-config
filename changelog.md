# What has changed

## 2025-04-26

### Added

- `git` profile for work
- `vscode` now also has a csv extension in path

### Modified

- `vscode.<foo>` to `vscode.profiles.default.<foo>`
- `vscode` now uses `pkgs.vscodium` instead
  + this is also reflected in the shell scripts for fixing vscode

### Removed

- `jetbrains-toolbox` (I manage everything through nix anyway)
- some *todo* annotations
- vscode pvs plugin
  + this does not work on MX chips
  + I would use Lean in the future if I need / want to

## 2025-04-18

### Added

- `nix-homebrew` to pin homebrew to the flake

### Modified

- Changed system from `x86` to `aarch`

### Removed

- `logitech-ghub` since it caused some chmod trouble (installed it manually)
- `R` and the its related things

## 2025-02-17

### Added

- Signal Shifter (mas)
  + this is a replacement for background music, which was buggy

## 2025-02-16

### Removed

- background music
	+ Super buggy. My sounds stops working randomly.
