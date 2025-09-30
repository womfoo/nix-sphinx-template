{
  description = "sphinx/mermaid flake template";
  inputs = {
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    nixago.inputs.nixago-exts.follows = "";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    nixago.url = "github:nix-community/nixago";
    nixpkgs.url = "github:NixOS/nixpkgs/8eb28ad";
    std.inputs.devshell.follows = "devshell";
    std.inputs.nixago.follows = "nixago";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.url = "github:divnix/std";
  };
  outputs =
    {
      std,
      self,
      ...
    }@inputs:
    std.growOn
      {
        inherit inputs;
        nixpkgsConfig.allowUnfree = true;
        cellsFrom = ./nix;
        cellBlocks = with std.blockTypes; [
          (devshells "shells")
          (functions "nixosModules")
          (installables "packages")
          (nixago "configs")
        ];
      }
      {
        devShells = inputs.std.harvest inputs.self [
          "repo"
          "shells"
        ];
        nixosModules = inputs.std.harvest inputs.self [
          "repo"
          "nixosModules"
        ];
        packages = std.harvest self [
          "repo"
          "packages"
        ];
      };
}
