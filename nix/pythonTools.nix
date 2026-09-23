{
  callPackage,
  python313,
}:
let
  sphinxcontrib-drawio = callPackage ./sphinxcontrib-drawio.nix { };
  sphinxcontrib-mermaid = callPackage ./sphinxcontrib-mermaid.nix { };
in
rec {
  python = python313;
  pythonEnv = (
    python313.withPackages (py3pkgs: [
      sphinxcontrib-mermaid
      sphinxcontrib-drawio
      py3pkgs.myst-parser
      py3pkgs.sphinx
      py3pkgs.sphinx-autobuild
      py3pkgs.sphinx-rtd-theme
    ])
  );
}
