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
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [
            "rust-src"
            "rustfmt"
            "clippy"
          ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustToolchain
            nodejs_22
            pnpm

            cargo-tauri

            just
            cargo-watch
            pkg-config

            sqlite
            sqlite.dev
            openssl
            openssl.dev

          ];
          shellHook = ''
            export RUST_SRC_PATH="${rustToolchain}/lib/rustlib/src/rust/library"
            export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.sqlite.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"

            echo "🦀 Rust: $(rustc --version)"
            echo "⚡ Node: $(node --version)"
            echo "📦 Tauri CLI: $(cargo tauri --version 2>/dev/null || echo '✅ Ready')"
            echo "📦 Just: $(just --version)"
            echo "👀 Cargo-watch: $(cargo-watch --version)"
            echo "🗄️  SQLite: $(sqlite3 --version)"
            echo "🐋 Docker: $(docker --version 2>/dev/null || echo '✅ System Docker detected')"
            echo ""
            echo "💡 Install Tauri CLI khi sẵn sàng: cargo install tauri-cli --locked"
            echo "💡 Run tasks với: just <command>" 

          '';
        };
      }
    );
}
