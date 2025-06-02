{pkgs, ...}: let
  teatimerGithub = pkgs.fetchFromGitHub {
    owner = "0xmycf";
    repo = "SimpleTeaTimer";
    rev = "1613eddef4ebd4cf011ac819bc7c671d3fff88e5";
    sha256 = "sha256-UhQwNhsHkYTqapZ292sEPo95LvlqCUcrxLVH2V8C0rQ=";
  };
  teatimer = pkgs.haskellPackages.callCabal2nix "teatimer" teatimerGithub {};
  teatimerNoHaddock = pkgs.haskell.lib.dontHaddock teatimer;

  gen-gitignore = pkgs.fetchFromGitHub {
    owner = "0xmycf";
    repo = "cli-gitignore-generator";
    rev = "3a7d029af7aa8c619936a05a9554261fca28b34f";
    sha256 = "sha256-61wmXbrVimUeiE5taT9CgRhJnQtRmXsRt77pNd0qUY0=";
  };
in {
  home.packages = [
    teatimerNoHaddock
    (import gen-gitignore {inherit pkgs;}).gen-gitignore
  ];
}
