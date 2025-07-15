{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "veridian";
  version = "d094c9d";

  src = fetchFromGitHub {
    owner = "vivekmalneedi";
    repo = "veridian";
    rev = "d094c9d2fa9745b2c4430eef052478c64d5dd3b6";
    hash = "sha256-3KjUunXTqdesvgDSeQMoXL0LRGsGQXZJGDt+xLWGovM=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  meta = {
    description = "A SystemVerilog Language Server ";
    homepage = "https://github.com/vivekmalneedi/veridian";
    license = lib.licenses.mit;
    maintainers = [];
  };
}
