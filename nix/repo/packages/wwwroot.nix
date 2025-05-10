{
  self,
  stdenv,
  python_with_sphinx,
  coreutils,
  drawio-headless,
  makeWrapper,
  xvfb,
}:

stdenv.mkDerivation {
  name = "wwwroot";
  src = self + /docs;

  # SOURCE_DATE_EPOCH = "315532800";
  /*
    FIXME: make epub work; none of ff work
    SOURCE_DATE_EPOCH = "315532800";
    preCheck = ''
      export SOURCE_DATE_EPOCH=315532800
    '';
    ensureNewerSourcesForZipFilesHook
    (ensureNewerSourcesHook { year = "1990";})
  */

  nativeBuildInputs = [
    makeWrapper
    drawio-headless
    python_with_sphinx
    coreutils
    xvfb
  ];
  makeFlags = [ "html" ];

  installPhase = ''
    mkdir -p $out
    cp -r _build/html/* $out/
  '';

}
