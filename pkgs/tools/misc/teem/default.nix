{ stdenv, fetchsvn, cmake, zlib }:

stdenv.mkDerivation rec {
  name = "teem-${version}";
  version = "1.10.0";

  src = fetchsvn {
    url = "https://svn.code.sf.net/p/teem/code/teem/tags/${version}";
  };

  buildInputs = [ cmake zlib ];

  cmakeFlags = [ ''-DTeem_PNG=OFF''
                 ''-DBUILD_SHARED_LIBS=ON'' ];

  meta = {
    homepage = http://teem.sourceforge.net;
    description = "Teem is a coordinated group of libraries for representing, processing, and visualizing scientific raster data";

    license = "LGPLv2.1";

    platforms = stdenv.lib.platforms.all;
  };
}
