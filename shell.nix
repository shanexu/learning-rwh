with import <nixpkgs> {};
let
  lrwh = (import ./default.nix);
  all-hie = (import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {});
in
haskellPackages.shellFor {
  name = lrwh.env.name;
  packages = p: [lrwh];
  buildInputs = [
    cabal-install
    haskellPackages.apply-refact
    haskellPackages.hlint
    haskellPackages.stylish-haskell
    haskellPackages.hasktags
    haskellPackages.hoogle
    haskellPackages.hindent
    (all-hie.selection { selector = p: { inherit (p) ghc865; }; })
  ];
}


