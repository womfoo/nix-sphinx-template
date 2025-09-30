{
  inputs,
  cell,
}:
let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
  n2c = inputs.n2c.packages.nix2container;

  nixEnv =
    inputs.std.lib.ops.mkSetup "flake-env"
      [
      ]
      ''
        mkdir -p $out/etc/nix
        echo "sandbox = false" >> $out/etc/nix/nix.conf
        echo "accept-flake-config = true" >> $out/etc/nix/nix.conf
        echo "experimental-features = nix-command flakes" >> $out/etc/nix/nix.conf
      '';

in
rec {
  bbUpstream = n2c.pullImage {
    imageName = "atlassian/default-image"; # ver 5 below
    imageDigest = "sha256:b39defa115850a9d0ceb11d677cbc78fc66a2008e55086a88efad45c0ae41f42";
    sha256 = "sha256-EjvrrbYtPa3yU0wEos8Q98iKj2IvJ7o83JCYYwiTLl8=";
  };

  bbBuilder = n2c.buildImage {
    name = "docker.io/kranium/nix-sphinx-builder";
    tag = "0.0.0";
    fromImage = bbUpstream;
    config = {
      entrypoint = [ "${nixpkgs.bashInteractive}/bin/bash" ];
    };
    layers = [
      (n2c.buildLayer {
        copyToRoot = [
          nixEnv
          nixpkgs.bash
          nixpkgs.nix
        ];
      })
      (n2c.buildLayer { deps = [ cell.shells.default ]; })
    ];
  };

}
