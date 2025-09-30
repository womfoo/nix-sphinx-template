{
  description = "sphinx/mermaid flake template";
  inputs = {
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";
    n2c.url = "github:nlewo/nix2container";
    n2c.inputs.nixpkgs.follows = "nixpkgs";
    nixago.inputs.nixago-exts.follows = "";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    nixago.url = "github:nix-community/nixago";
    nixpkgs.url = "github:NixOS/nixpkgs/9f0c42f8bc7151b8e7e5840fb3bd454ad850d8c5";
    std.inputs.devshell.follows = "devshell";
    std.inputs.nixago.follows = "nixago";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.n2c.follows = "n2c";
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
          (containers "containers")
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
          [
            "repo"
            "packages"
          ]
          [
            "repo"
            "containers"
          ]
        ];
      };
}
