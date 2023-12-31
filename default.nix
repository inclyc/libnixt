{ lib
, stdenv
, lit
, meson
, boost
, ninja
, nix
, pkg-config
}:
let
  filterMesonBuild = dir: builtins.filterSource
    (path: type: type != "directory" || baseNameOf path != "build")
    dir;
in
stdenv.mkDerivation {
  pname = "libnixt";
  version = "0.0.0";

  src = filterMesonBuild ./.;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  nativeCheckInputs = [
    lit
  ];

  doCheck = true;

  outputs = [ "bin" "out" "dev" ];

  env.CXXFLAGS = "-include ${nix.dev}/include/nix/config.h";

  buildInputs = [
    boost
    nix
  ];

}
