{
  inputs,
  cell,
}:
let
  inherit (inputs.nixpkgs)
    lib
    callPackage
    python3
    ensureNewerSourcesForZipFilesHook
    ensureNewerSourcesHook
    coreutils
    drawio-headless
    xvfb
    ;
  inherit (inputs.std.lib.ops) writeScript;
in
rec {
  default = wwwroot;
  impure-sphinx-build = writeScript {
    name = "impure-sphinx-build";
    runtimeInputs = [
      python_with_sphinx
    ];
    text = ''
      sphinx-autobuild "''${PRJ_ROOT}/docs/" "''${PRJ_ROOT}/docs/_build/" "''$@"
    '';
  };

  wwwroot = callPackage ./wwwroot.nix {
    inherit (inputs) self;
    inherit python_with_sphinx;
  };
  sphinxcontrib-drawio = callPackage ./sphinxcontrib-drawio.nix { };
  sphinxcontrib-mermaid = callPackage ./sphinxcontrib-mermaid.nix { };
  python_with_sphinx =
    (python3.withPackages (py3pkgs: [
      sphinxcontrib-mermaid
      sphinxcontrib-drawio
      py3pkgs.myst-parser
      py3pkgs.sphinx
      py3pkgs.sphinx-autobuild
      py3pkgs.sphinx-rtd-theme
    ]))
    // {
      meta.description = "python with sphinx-{build,quickstart,etc.}";
    };
}
