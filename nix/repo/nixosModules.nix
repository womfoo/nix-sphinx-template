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
      inherit (lib) mkIf mkOption types;
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
            default = "localhost";
          };
        };
      };
      config =
        let
          cfg = config.services.sphinx-nginx;
        in
        mkIf cfg.enable {
          services.nginx.virtualHosts."${cfg.virtualHost}" = {
            locations = {
              "/" = {
                root = inputs.cells.repo.packages.wwwroot;
              };
            };
          };
        };
    };
}
