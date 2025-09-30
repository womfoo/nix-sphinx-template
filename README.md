# nix-sphinx-template

Nix [Sphinx](https://www.sphinx-doc.org/) template with:
- [myst-parser](https://myst-parser.readthedocs.io/en/latest/)
- [sphinx-rtd-theme](https://sphinx-rtd-theme.readthedocs.io/en/stable/)
- [sphinxcontrib-drawio](https://github.com/modelmat/sphinxcontrib-drawio/)
- [sphinxcontrib-mermaid](https://github.com/mgaitan/sphinxcontrib-mermaid/)

## Quickstart
1. `nix build`
2. see generated site at result/index.html

or live updates with uncommited git changes:

1. `impure-sphinx-autobuild` # default port 8000 or pass --port n
2. see http://localhost:8000 # or specified port

## NixOS Flake

1. `flake.nix`

     ```nix
       inputs = {
         sphinx.url = "github:womfoo/nix-sphinx-template";
       }
     ```

     ```nix
       modules = [
          inputs.sphinx.nixosModules.default
          {services.sphinx-nginx.enable = true;}
          {services.sphinx-nginx.virtualHost = "your.doc.site.com";}
       ];
     ```
