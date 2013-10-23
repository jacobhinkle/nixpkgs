{stdenv, fetchurl, unzip, xulrunner, bash}:
let
  s = # Generated upstream information
  rec {
    baseName="slimerjs";
    version="0.8.3";
    name="${baseName}-${version}";
    hash="07gwiay2pbzyscn8gnwb8i92xffjahhinlswc1z4h8dbjk837d8h";
    url="http://download.slimerjs.org/v0.8/slimerjs-0.8.3.zip";
    sha256="07gwiay2pbzyscn8gnwb8i92xffjahhinlswc1z4h8dbjk837d8h";
  };
  buildInputs = [
    unzip
  ];
in
stdenv.mkDerivation {
  inherit (s) name version;
  inherit buildInputs;
  src = fetchurl {
    inherit (s) url sha256;
  };
  installPhase = ''
    mkdir -p "$out"/{bin,share/doc/slimerjs,lib/slimerjs}
    cp LICENSE README* "$out/share/doc/slimerjs"
    cp * "$out/lib/slimerjs"
    echo '#!${bash}/bin/bash' >>  "$out/bin/slimerjs"
    echo 'export SLIMERJSLAUNCHER=${xulrunner}/bin/xulrunner' >>  "$out/bin/slimerjs"
    echo "'$out/lib/slimerjs/slimerjs' \"\$@\"" >> "$out/bin/slimerjs"
    chmod a+x "$out/bin/slimerjs"
  '';
  meta = {
    inherit (s) version;
    description = ''Gecko-based programmatically-driven browser'';
    license = stdenv.lib.licenses.mpl20 ;
    maintainers = [stdenv.lib.maintainers.raskin];
    platforms = stdenv.lib.platforms.linux;
  };
}