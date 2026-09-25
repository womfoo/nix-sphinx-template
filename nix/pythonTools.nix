{
  callPackage,
  python313,
}:
let
  sphinxcontrib-mermaid = callPackage ./sphinxcontrib-mermaid.nix {
    python3Packages = python313.pkgs;
  };
in
rec {
  python = python313;
  pythonEnv = (
    python313.withPackages (py3pkgs: [
      sphinxcontrib-mermaid
      py3pkgs.myst-parser
      py3pkgs.pydata-sphinx-theme
      py3pkgs.sphinx
      py3pkgs.sphinx-autobuild
    ])
  );
}
