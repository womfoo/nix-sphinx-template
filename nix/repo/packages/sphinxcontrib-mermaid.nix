{
  fetchPypi,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "sphinxcontrib-mermaid";
  version = "1.0.0";

  dependencies = [
    python3Packages.pyyaml
    python3Packages.sphinx
  ];

  build-system = [ python3Packages.setuptools ];

  src = fetchFromGitHub {
    owner = "mgaitan";
    repo = pname;
    tag = version;
    hash = "sha256-OO2fbtB2qLjsIGjRJrBDDRn8dT9qowfU6i8qRBbDRTM=";
  };

  pyproject = true;
  pythonNamespaces = [ "sphinxcontrib" ];
}
