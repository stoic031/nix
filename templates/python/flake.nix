{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        pythonEnv = pkgs.python312.withPackages (ps: with ps; [
          pip
          virtualenv
          ipython
          numpy
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pythonEnv
            pkgs.zlib
          ];

          shellHook = ''
            echo "🐍 Python AI Dev — Apple Silicon (aarch64-darwin)"
            echo "Python: $(python --version)"

            # Tạo .venv cục bộ để cài PyTorch/MLX qua pip
            # (nixpkgs chưa build PyTorch với MPS trên darwin)
            if [ ! -d .venv ]; then
              python -m venv .venv
              echo "✅ Created .venv"
            fi
            source .venv/bin/activate
          '';
        };
      };
    );
  };
}
