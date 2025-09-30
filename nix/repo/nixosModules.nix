{
  inputs,
  cell,
}:
{
  default =
    {
      config,
      lib,
      options,
      ...
    }:
    let
      inherit (lib) mkOption types mkIf;
    in
    {
      options = {
        services.sphinx-nginx = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Whether to run this module.
            '';
          };
          virtualHost = mkOption {
            type = types.str;
          };
        };
      };
      config =
        let
          cfg = config.services.sphinx-nginx;
        in
        mkIf cfg.enable {
          services.nginx.virtualHosts."localca" = {
            locations = {
              "/" = {
                root = inputs.cells.repo.packages.wwwroot;
              };
            };
          };
        };
    };
}
