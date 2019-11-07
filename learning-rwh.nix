{ nix-gitignore, mkDerivation, base, bytestring, directory, filepath, regex-posix, time, QuickCheck, array, containers, hpack, stdenv }:
mkDerivation {
  pname = "learning-rwh";
  version = "0.1.0.0";
  src = nix-gitignore.gitignoreSourcePure [./.gitignore] ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base bytestring directory ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [ base bytestring directory filepath regex-posix time QuickCheck array containers];
  testHaskellDepends = [ base bytestring directory ];
  prePatch = "hpack";
  homepage = "https://github.com/githubuser/learning-rwh#readme";
  license = stdenv.lib.licenses.bsd3;
}
