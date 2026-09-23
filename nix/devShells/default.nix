{ ... }:
{
  perSystem =
    { pkgs, sphinxLib, ... }:
    let
      inherit (sphinxLib) impure-sphinx-autobuild;
      inherit (sphinxLib.pythonTools) pythonEnv;
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          # gnumake
          impure-sphinx-autobuild
          # mermaid-cli
          pythonEnv
        ];
        shellHook = ''
          export PRJ_ROOT=$(${pkgs.git}/bin/git rev-parse --show-toplevel)
        '';
      };
    };
}
