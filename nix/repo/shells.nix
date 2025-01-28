{
  inputs,
  cell,
}:
let
  inherit (inputs.std.lib) dev cfg;
in
{
  default = inputs.std.lib.dev.mkShell {
    commands = with inputs.nixpkgs.pkgs; [
      { package = mermaid-cli; } # this brings in chromium-unwrapped ~700MB
      { package = cell.packages.python_with_sphinx; }
      {
        # for building in devshell
        package = gnumake;
        category = "compatibility";
      }
    ];

    nixago = [
      cell.configs.treefmt
    ];
  };
}
