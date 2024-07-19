# This flake provides a reproducible development environment for use with 
# "x86_64-linux" "aarch64-linux" "x86_64-darwin" and "aarch64-darwin" architectures
{
  description = "Terraform Dev Flake";

  # Define flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Use Nix Packages unstable branch
    flake-utils.url = "github:numtide/flake-utils";       # Use flake-utils system for x86_64/ARM/darwin compatibility
  };

  # Define flake outputs
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in
      {
        # Define packages available to the development environment
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.terraform
            pkgs.docker
          ];

          shellHook = ''
            echo "
            -> Terraform dev environment ready - courtesy of seabear (Surf-Wax on GitHub)
            "
          '';
        };
      });
}