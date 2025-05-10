{
  fetchPypi,
  fetchFromGitHub,
  python3Packages,
  strace,
}:

python3Packages.buildPythonPackage rec {
  pname = "sphinxcontrib-drawio";
  version = "0.0.17";

  src = fetchFromGitHub {
    owner = "modelmat";
    repo = pname;
    tag = version;
    hash = "sha256-QoI7tnY0WPMDFXya4+2UvhXi8LHkZf8n2ekZ045l/60=";
  };

  patches = [
    ./force-embed-svg-images.patch
  ];
  pythonNamespaces = [ "sphinxcontrib" ];
}
