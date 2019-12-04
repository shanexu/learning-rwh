{ nix-gitignore, mkDerivation, base, bytestring, directory, filepath, regex-posix, time, random, QuickCheck, array, containers, mtl, parsec, hpack, stdenv }:
mkDerivation {
  pname = "learning-rwh";
  version = "0.1.0.0";
  src = nix-gitignore.gitignoreSourcePure [./.gitignore] ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base bytestring directory filepath regex-posix time QuickCheck array containers random mtl parsec ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [ base bytestring directory filepath regex-posix time QuickCheck array containers random mtl parsec ];
  testHaskellDepends = [ base bytestring directory filepath regex-posix time QuickCheck array containers random mtl parsec ];
  prePatch = "hpack";
  homepage = "https://github.com/githubuser/learning-rwh#readme";
  license = stdenv.lib.licenses.bsd3;
}
