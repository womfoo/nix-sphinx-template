{
  inputs,
  cell,
}:
let
  inherit (inputs.std.lib.dev) mkNixago;
in
{
  default = inputs.std.lib.dev.mkShell {
    commands = with inputs.nixpkgs.pkgs; [
      { package = mermaid-cli; } # this brings in chromium-unwrapped ~700MB
      { package = cell.packages.python_with_sphinx; }
      { package = cell.packages.impure-sphinx-build; }
      {
        # for building in devshell
        package = gnumake;
        category = "compatibility";
      }
    ];
    nixago = [
      (mkNixago cell.configs.treefmt)
      (mkNixago inputs.std.data.configs.conform)
      (mkNixago inputs.std.data.configs.lefthook)
    ];
  };
}
