{
  lib,
  stdenv,
  fetchzip,
  autoPatchelfHook,
  libplist,
  p11-kit,
  libimobiledevice,
}:
stdenv.mkDerivation rec {
  pname = "jitterbugpair";
  version = "1.3.1";

  src = fetchzip {
    url = "https://github.com/osy/Jitterbug/releases/download/v${version}/jitterbugpair-linux.zip";
    sha256 = "sha256-xQ+thkNy9fKUOi80FgfFham3NAZ6VgXbahzkAtdS6cg=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    libplist.out
    p11-kit
    libimobiledevice
  ];

  preFixup = ''
    patchelf --remove-needed libplist.so.3 $out/bin/jitterbugpair
    patchelf --add-needed libplist-2.0.so $out/bin/jitterbugpair
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 $src/jitterbugpair "$out/bin/jitterbugpair"
    runHook postInstall
  '';

  meta = with lib; {
    changelog = "https://github.com/osy/Jitterbug/releases/tag/v${version}";
    description = "Launch JIT enabled iOS app with a second iOS device";
    homepage = "https://github.com/osy/Jitterbug";
    maintainers = [];
    license = licenses.asl20;
  };
}
