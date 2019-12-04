let
  lrwh = (import ./default.nix);
  all-hies = (import ./pkgs.nix).all-hies {};
  pkgs = (import ./pkgs.nix).pkgs {};
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
    (all-hies.selection { selector = p: { inherit (p) ghc865; }; })
  ];
}
