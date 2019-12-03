let
  lrwh = (import ./default.nix);
  all-hie = (import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {});
  pkgs = import <nixpkgs> {};
in
pkgs.haskellPackages.shellFor {
  name = "learning-rwh-nix-shell";
  packages = p: [lrwh];
  buildInputs = [
    pkgs.bashInteractive
    pkgs.cabal-install
    pkgs.stack
    pkgs.haskellPackages.apply-refact
    pkgs.haskellPackages.hlint
    pkgs.haskellPackages.stylish-haskell
    pkgs.haskellPackages.hasktags
    pkgs.haskellPackages.hoogle
    pkgs.haskellPackages.hindent
    (all-hie.selection { selector = p: { inherit (p) ghc865; }; })
  ];
}
