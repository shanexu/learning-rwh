let
  pkgs = import <nixpkgs> { };
in
  pkgs.haskellPackages.callPackage ./learning-rwh.nix { }
