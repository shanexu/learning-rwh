let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          learning-rwh = haskellPackages.callPackage ./learning-rwh.nix { };
        };
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
in
  pkgs.haskellPackages.learning-rwh
