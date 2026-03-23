{pkgs, ...}: {
  home.packages = with pkgs; [
    (haskellPackages.ghcWithPackages (pkgs:
      with pkgs; [
        cabal-install
        haskell-language-server
        turtle
        pipes
        pipes-safe
        pipes-bytestring
        pipes-text
        pipes-aeson
        aeson
        containers
        # unordered-containers
        text
        transformers
        mtl
        bytestring
        vector
        linear
        filepath
        deepseq
        time
        directory
        megaparsec
        lens
        optparse-applicative
      ]))
  ];
}
