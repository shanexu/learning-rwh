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
  pkgs = (import ./pkgs.nix).pkgs { inherit config; };
in
pkgs.haskellPackages.learning-rwh
