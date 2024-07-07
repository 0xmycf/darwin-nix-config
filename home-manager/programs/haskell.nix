{pkgs, ...}: {
  home.packages = with pkgs; [
    (haskellPackages.ghcWithPackages (pkgs: with pkgs; [cabal-install haskell-language-server]))
  ];
}
