{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      ripgrep
      fd
      fzf
      jq
      awscli2
      eza
      unzip
      zoxide
      delta
      dust
      starship
      neovim
      bat
      tmux
      stow
      luajit
      luajitPackages.luarocks
      tree-sitter
      prettier
      nixfmt
      nodejs
      cspell
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      mas

    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
      xclip
      htop
    ];

}
