{ mkDerivation, base, bytestring, directory, hpack, stdenv }:
mkDerivation {
  pname = "learning-rwh";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base bytestring directory ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [ base bytestring directory ];
  testHaskellDepends = [ base bytestring directory ];
  prePatch = "hpack";
  homepage = "https://github.com/githubuser/learning-rwh#readme";
  license = stdenv.lib.licenses.bsd3;
}
