{
  description = "flake-parts configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      imports = [
        inputs.home-manager.flakeModules.home-manager
      ];
      flake = {
        homeModules = {
          vscode-settings = ./modules/vscode-settings.nix;
          default-system-utils = ./modules/default-system-utils.nix;
        };
      };
    };
}
