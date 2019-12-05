let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/8d9b0e770c8e2264ef4882623a205548d9fdaa03");
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs-channels/tarball/14c1a446d88f6a5369098af2f7e884969085f14d");

in
{ inherit all-hies pkgs;
}

