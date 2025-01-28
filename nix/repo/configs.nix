{
  inputs,
  cell,
}:
let
  inherit (inputs) nixpkgs;
  inherit (inputs.std.data) configs;
  inherit (inputs.std.lib.dev) mkNixago;
in
{
  treefmt = (mkNixago configs.treefmt) {
    data.formatter.nix = {
      command = nixpkgs.lib.getExe nixpkgs.nixfmt-rfc-style;
    };
  };
}
