{
  description = "Andy's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      mac-app-util,
      ...
    }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      # Templates
      templates = {
        rust = {
          path = ./templates/rust;
          description = "Rust development environment";
        };
        python = {
          path = ./templates/python;
          description = "Python AI/ML development environment";
        };
        tauri = {
          path = ./templates/tauri;
          description = "Tauri application development environment";
        };
      };

      # Darwin configurations
      darwinConfigurations."Andys-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/mac/default.nix
          mac-app-util.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            nix-homebrew = {
              enable = true;
              autoUpdate = true;
              user = "andy";
            };

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.andy = import ./home/default.nix;
            };
          }
        ];
      };

      # Development shells for all systems
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nixfmt-classic
              shellcheck
            ];
          };
        }
      );
    };
}
