# What has changed

## 2026-10-12

### Added
- `chatgpt` as a Homebrew cask.
- `rust-overlay` following the existing locked `nixpkgs` input.
- Locked only the new overlay input; all existing input revisions are preserved.

### Changed
- Documented Chrome as a fallback for VIA's web-based Keychron launcher.
- Pinned Home Manager's Rust toolchain to `1.97.1`, including Cargo, rustfmt,
  Clippy, rust-analyzer, Rust sources, and GeoEngine's requested LLVM tools from
  the same release.
- Pointed `RUST_SRC_PATH` at the pinned toolchain's standard library sources.

### Removed
- Disabled the Homebrew casks `firefox`, `copilot-cli`, `webstorm`,
  `telegram-desktop`, `qgis`, `skim`, and `virtualbox` by commenting them out.

## 2026-03-18

### Changed
- Changed haskell lsp formatting provider from `stylish-haskell` to `fourmolu`
  + fourmolu creates smaller diffs on imports while also applying more unified 
    overall styling

## 2025-11-22

### Removed
- Deleted `oterm` program from `home-manager/home.nix`
- Disabled `ollama`, as it was refusing to build **todo: look into this and fix**

## 2025-07-10

### Added
- Anki as a cask

### Changed
- Renamed migrated casks (neovide, zen, docker)
- Updated flake inputs

## 2025-05-07

### Added

- `ghostty` brew cask
- `ghostty` settings (incl. `dark` and `light` fish functions to change its colortheme)

## 2025-05-05

### Added

- webstorm by jetbrains
- some mac specific configuration in `./mac-settings.nix`

## 2025-04-27

### Removed

- Disabled `ltex` lsp

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
