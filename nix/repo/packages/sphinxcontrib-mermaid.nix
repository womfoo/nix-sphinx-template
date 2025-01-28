{
  fetchPypi,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "sphinxcontrib-mermaid";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "mgaitan";
    repo = pname;
    tag = version;
    hash = "sha256-OO2fbtB2qLjsIGjRJrBDDRn8dT9qowfU6i8qRBbDRTM=";
  };

  pythonNamespaces = [ "sphinxcontrib" ];
}
