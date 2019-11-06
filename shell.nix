with import <nixpkgs> {};
let
  lrwh = (import ./default.nix);
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
  ];
}


