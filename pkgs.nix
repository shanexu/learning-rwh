let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/8d9b0e770c8e2264ef4882623a205548d9fdaa03");
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs-channels/tarball/nixpkgs-unstable/f97746ba2726128dcf40134837ffd13b4042e95d");

in
{ inherit all-hies pkgs;
}

