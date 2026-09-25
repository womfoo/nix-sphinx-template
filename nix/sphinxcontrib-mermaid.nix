{
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "sphinxcontrib-mermaid";
  version = "2.1.1";

  dependencies = [
    python3Packages.jinja2
    python3Packages.pyyaml
    python3Packages.sphinx
  ];

  build-system = [ python3Packages.hatchling ];

  src = fetchFromGitHub {
    owner = "mgaitan";
    repo = pname;
    tag = version;
    hash = "sha256-lRPZDfFjrA4xCAOa/GzZVyTRPaTcyFWUSVyombPvIMk=";
  };

  pyproject = true;
  pythonNamespaces = [ "sphinxcontrib" ];
}
