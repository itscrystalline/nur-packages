{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  python3,
  withDynarec ? (
    stdenv.hostPlatform.isAarch64 || stdenv.hostPlatform.isRiscV64 || stdenv.hostPlatform.isLoongArch64
  ),
  mold-unwrapped,
  libc,
}:
# Currently only supported on specific archs
assert withDynarec
-> (
  stdenv.hostPlatform.isAarch64 || stdenv.hostPlatform.isRiscV64 || stdenv.hostPlatform.isLoongArch64
);
  stdenv.mkDerivation (finalAttrs: {
    pname = "box64-static";
    version = "0.4.0";

    src = fetchFromGitHub {
      owner = "ptitSeb";
      repo = "box64";
      tag = "v${finalAttrs.version}";
      hash = "sha256-ihg7sos2pyyZjXiYMct/gg/ianiu0yagNtXio+A7J3c=";
    };

    # Setting cpu doesn't seem to work (or maybe isn't enough / gets overwritten by the wrapper's arch flag?), errors about unsupported instructions for target
    # (this is for code that gets executed conditionally if the cpu at runtime supports their features, so setting this should be fine)
    postPatch = ''
      substituteInPlace CMakeLists.txt \
        --replace-fail 'ASMFLAGS  -pipe -mcpu=cortex-a76' 'ASMFLAGS  -pipe -march=armv8.2-a+fp16+dotprod' \
        --replace-fail 'set(CMAKE_EXE_LINKER_FLAGS -static)' 'set(CMAKE_EXE_LINKER_FLAGS "-static -L${libc.static}/lib")'
    '';

    nativeBuildInputs = [
      cmake
      python3
      mold-unwrapped
    ];

    cmakeFlags =
      [
        (lib.cmakeBool "NOGIT" true)

        (lib.cmakeBool "WITH_MOLD" true)
        (lib.cmakeBool "STATICBUILD" true)

        # Arch mega-option
        (lib.cmakeBool "ARM64" stdenv.hostPlatform.isAarch64)
        (lib.cmakeBool "RV64" stdenv.hostPlatform.isRiscV64)
        (lib.cmakeBool "PPC64LE" (stdenv.hostPlatform.isPower64 && stdenv.hostPlatform.isLittleEndian))
        (lib.cmakeBool "LARCH64" stdenv.hostPlatform.isLoongArch64)
      ]
      ++ lib.optionals stdenv.hostPlatform.isx86_64 [
        # x86_64 has no arch-specific mega-option, manually enable the options that apply to it
        (lib.cmakeBool "LD80BITS" true)
        (lib.cmakeBool "NOALIGN" true)
      ]
      ++ [
        # Arch dynarec
        (lib.cmakeBool "ARM_DYNAREC" (withDynarec && stdenv.hostPlatform.isAarch64))
        (lib.cmakeBool "RV64_DYNAREC" (withDynarec && stdenv.hostPlatform.isRiscV64))
        (lib.cmakeBool "LARCH64_DYNAREC" (withDynarec && stdenv.hostPlatform.isLoongArch64))
      ];

    installPhase = ''
      runHook preInstall

      install -Dm 0755 box64 "$out/bin/box64"

      runHook postInstall
    '';

    doCheck = stdenv.buildPlatform.canExecute stdenv.hostPlatform;

    doInstallCheck = stdenv.buildPlatform.canExecute stdenv.hostPlatform;

    installCheckPhase = ''
      runHook preInstallCheck

      echo Checking if it works
      $out/bin/box64 -v

      echo Checking if Dynarec option was respected
      $out/bin/box64 -v 2>&1 | grep ${lib.optionalString (!withDynarec) "-v"} Dynarec

      runHook postInstallCheck
    '';

    meta = {
      homepage = "https://box86.org/";
      description = "Lets you run x86_64 Linux programs on non-x86_64 Linux systems";
      changelog = "https://github.com/ptitSeb/box64/releases/tag/v${finalAttrs.version}";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [
        gador
        OPNA2608
      ];
      mainProgram = "box64";
      platforms = [
        "x86_64-linux"
        "aarch64-linux"
        "riscv64-linux"
        "powerpc64le-linux"
        "loongarch64-linux"
        "mips64el-linux"
      ];
    };
  })
