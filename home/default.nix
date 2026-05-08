{ config, pkgs, ... }: {
  home.username = "andy";
  home.homeDirectory = "/Users/andy";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;


  myConfig = {
    terminal = "ghostty";
    opacity   = 0.95;
    font.name = "SF Mono";
  };
  
  imports = [
  ./terminal/options.nix
  ./terminal/default.nix
  ./shell.nix
  ./git.nix
  ./neovim.nix
  ./packages.nix
  ./tmux.nix
  ];
}
