let
  all-hies = import (fetchTarball {
    url = "https://github.com/infinisil/all-hies/archive/8d9b0e770c8e2264ef4882623a205548d9fdaa03.tar.gz";
    sha256 = "1lqvyn3as7wp4njdk4hl34qiwbnys192shv425jvw27014hgl3vy";
  });

  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/14c1a446d88f6a5369098af2f7e884969085f14d.tar.gz";
    sha256 = "0psqh1g5zzh5c6yg1qfg1l3bzpr92sphk6rs88qv6kgx83a4dyxh";
  });

in
{ inherit all-hies pkgs;
}

