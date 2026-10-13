{ lib, stdenvNoCC, fetchurl, unzip }:

stdenvNoCC.mkDerivation rec {
  pname = "mudita-center";
  version = "4.0.0";

  src = fetchurl {
    url = "https://github.com/mudita/mudita-center/releases/download/${version}/Mudita-Center.zip";
    hash = "sha256-fqaChLPIXB1oIpp3Is9NQ1NOYCujNAfmBSbum2aQKiU=";
  };

  nativeBuildInputs = [ unzip ];
  sourceRoot = ".";

  # Pre-built, signed app bundle: don't touch it
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R "Mudita Center.app" $out/Applications/
    runHook postInstall
  '';

  meta = {
    description = "Desktop companion app for Mudita phones";
    homepage = "https://mudita.com/products/software-apps/mudita-center/";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
