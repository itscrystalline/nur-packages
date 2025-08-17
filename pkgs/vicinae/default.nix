{
  lib,
  fetchurl,
  stdenv,
  nodejs,
  qt6,
  protobuf,
  cmark-gfm,
  libqalculate,
  minizip,
  kdePackages,
  autoPatchelfHook,
  openssl,
  abseil-cpp,
  wayland,
}:
# https://github.com/knoopx/nix/blob/master/modules/home-manager/services/vicinae.nix
stdenv.mkDerivation rec {
  pname = "vicinae";
  version = "0.1.0";

  src = fetchurl {
    url = "https://github.com/vicinaehq/vicinae/releases/download/v${version}/vicinae-linux-x86_64-v${version}.tar.gz";
    sha256 = "sha256-HYynXER3KUtMbhHJMMtzAICPsWfQXC3ck2gqQX2AQD0=";
  };

  nativeBuildInputs = [autoPatchelfHook qt6.wrapQtAppsHook];
  buildInputs = [
    qt6.qtbase
    qt6.qtsvg
    qt6.qttools
    qt6.qtwayland
    qt6.qtdeclarative
    qt6.qt5compat
    kdePackages.qtkeychain
    kdePackages.layer-shell-qt
    openssl
    cmark-gfm
    libqalculate
    minizip
    stdenv.cc.cc.lib
    abseil-cpp
    protobuf
    nodejs
    wayland
  ];

  unpackPhase = ''
    tar -xzf $src
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/applications
    cp bin/vicinae $out/bin/
    cp share/applications/vicinae.desktop $out/share/applications/
    chmod +x $out/bin/vicinae
  '';

  dontWrapQtApps = true;

  preFixup = ''
    wrapQtApp "$out/bin/vicinae" --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}
  '';

  meta = {
    description = "A focused launcher for your desktop — native, fast, extensible";
    homepage = "https://github.com/vicinaehq/vicinae";
    license = lib.licenses.gpl3;
    maintainers = [];
    platforms = lib.platforms.linux;
  };
}
