{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  pname = "app2unit";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "Vladimir-csp";
    repo = "app2unit";
    rev = "9f19342ed9195abbe9473805534103627f4ca190";
    hash = "sha256-fw6Vh3Jyop95TQdOFrpspbauSfqMpd0BZkZVc1k6+K0=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/app2unit $out/bin
    cp $src/app2unit-open $out/bin
    cp $src/app2unit-term $out/bin
  '';
}
