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
        secrets = import ./secrets.nix; # import secrets
        #dockerImage = pkgs.dockerTools.buildImage {
        #  name = "twingate-connector";
        #  tag = "latest";
        #  config = {
        #    Cmd = [ "--sysctl" "net.ipv4.ping_group_range=\"0 2147483647\"" ];
        #    Env = [
        #      "TWINGATE_NETWORK=${secrets.twingateNetwork}"
        #      "TWINGATE_ACCESS_TOKEN=${secrets.twingateApiKey}"
        #      "TWINGATE_REFRESH_TOKEN=" # Need the terraform to run first to generate this
        #      "TWINGATE_LABEL_HOSTNAME=`hostname`"
        #      "TWINGATE_LABEL_DEPLOYED_BY=docker"
        #    ];
        #  };
        #  contents = [ pkgs.sysctl ]; 
        #};
      in
      {
        # Define packages available to the development environment
        #packages.default = dockerImage;

        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.terraform
          ];

          terraformInit = pkgs.writeScript "terraform-init.sh" ''
            export TF_VAR_twingate_api_key="${secrets.twingateApiKey}"
            export TF_VAR_twingate_network="${secrets.twingateNetwork}"
            export TF_VAR_twingate_remote_network_name="${secrets.twingateRemoteNetwork}"
            export TF_VAR_twingate_user_id="${secrets.twingateUserId}"
            export TF_VAR_twingate_resource_address="192.168.1.3"
            export TF_VAR_twingate_connector_name="home-computer-connector"
            export TF_VAR_twingate_label_hostname="`hostname`"
            export TF_VAR_twingate_label_deployed_by="docker"
            # terraform init
            '';

          shellHook = ''
            if command -v docker &> /dev/null; then
              echo "
              Docker is Installed"
            else
              echo "Docker not found. Please install Docker."
            fi
            echo "
            -> Terraform dev environment ready - courtesy of seabear (Surf-Wax on GitHub)
            "
            ./terraform-init
          '';
        };
      });
}