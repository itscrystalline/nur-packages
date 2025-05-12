{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: rec {
  pname = "occasion";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "itscrystalline";
    repo = "occasion";
    rev = "v${version}";
    hash = "sha256-A7/tsAiGlXxvcCc+MxKs/QH4YZ2vERJpccKNabpGP/U=";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
  };

  meta = {
    description = "A small program to print something / run a command on a specific time/timeframe. ";
    homepage = "https://github.com/itscrystalline/occasion";
    license = lib.licenses.unlicense;
    maintainers = [];
  };
})
