{pkgs, ...}: let
  teatimerGithub = pkgs.fetchFromGitHub {
    owner = "0xmycf";
    repo = "SimpleTeaTimer";
    rev = "1613eddef4ebd4cf011ac819bc7c671d3fff88e5";
    sha256 = "sha256-UhQwNhsHkYTqapZ292sEPo95LvlqCUcrxLVH2V8C0rQ=";
  };
  teatimer = pkgs.haskellPackages.callCabal2nix "teatimer" teatimerGithub {};
  teatimerNoHaddock = pkgs.haskell.lib.dontHaddock teatimer;
in {
  home.packages = [
    teatimerNoHaddock
  ];
}
