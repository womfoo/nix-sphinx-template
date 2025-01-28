{
  inputs,
  cell,
}:
let
  inherit (inputs.nixpkgs)
    lib
    # buildGoModule
    callPackage
    # fetchfromGithub
    python3
    ensureNewerSourcesForZipFilesHook
    # python3Packages
    # fetchPypi
    ensureNewerSourcesHook
    coreutils
    ;

in
rec {
  default = wwwroot;
  wwwroot = callPackage ./wwwroot.nix {
    inherit (inputs) self;
    python_with_sphinx = python_with_sphinx;
  };
  sphinxcontrib-mermaid = callPackage ./sphinxcontrib-mermaid.nix { };
  python_with_sphinx =
    (python3.withPackages (py3pkgs: [
      sphinxcontrib-mermaid
      py3pkgs.myst-parser
      py3pkgs.sphinx
      py3pkgs.sphinx_rtd_theme
    ]))
    // {
      meta.description = "python with sphinx-{build,quickstart,etc.}";
    };
}
