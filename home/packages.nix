{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # File utilities
    ripgrep
    fd
    fzf
    jq
    eza
    unzip
    zoxide

    # Development tools
    delta
    dust
    starship
    neovim
    bat
    tmux
    stow

    # Lua & Tree-sitter
    luajit
    luajitPackages.luarocks
    tree-sitter

    # Web development
    prettier
    nixfmt-classic
    nodejs
    cspell

    # Cloud
    awscli2
  ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
    mas
  ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
    xclip
    htop
  ];
}
