{
  fetchPypi,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "sphinxcontrib-drawio";
  version = "0.0.17";

  dependencies = [
    python3Packages.sphinx
  ];

  build-system = [ python3Packages.setuptools ];

  src = fetchFromGitHub {
    owner = "modelmat";
    repo = pname;
    tag = version;
    hash = "sha256-QoI7tnY0WPMDFXya4+2UvhXi8LHkZf8n2ekZ045l/60=";
  };

  patches = [
    ./force-embed-svg-images.patch
  ];

  pyproject = true;
  pythonNamespaces = [ "sphinxcontrib" ];
}
