{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      rust-overlay,
    }:
    flake-utils.lib.eachDefaultSystem {
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
        rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in 
      {
        devShells.default = pkgs.mkShell {
          packages = [
            rustToolchain
            pkgs.rust-analyzer
            pkgs.nodejs_20
            pkgs.pnpm
            pkgs.openssl
            pkgs.pkg-config
            pkgs.sqlite
            pkgs.just
            pkgs.cargo-watch
          ];

          shellHook = ''
            export RUST_BACKTRACE=1
            export PATH="$PWD/node_modules/.bin:$PATH"
            echo "🦀 Rust $(rustc --version)"
            echo "📦 Node $(node --version) | pnpm $(pnpm --version)"
            echo "🌲 Tauri 2.0 Dev Environment Ready"
            echo "👉 Next: pnpm create tauri-app . --template vue-ts"
          '';
        };
      }
    };
}
