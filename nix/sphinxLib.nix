{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      _module.args.sphinxLib = rec {
        version = builtins.replaceStrings [ "\n" ] [ "" ] (builtins.readFile ../version);
        pythonTools = pkgs.callPackage ./pythonTools.nix { };
        impure-sphinx-autobuild = pkgs.writeScriptBin "impure-sphinx-autobuild" ''
          sphinx-autobuild "''${PRJ_ROOT}/docs/" "''${PRJ_ROOT}/docs/_build/" "''$@"
        '';
      };
    };
}
