{ lib, config, pkgs, ... }: {
  home.username = "andy";
  home.homeDirectory = "/Users/andy";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;


  myConfig = {
    terminal = "ghostty";
    opacity   = 0.95;
    theme = "TokyoNight";
    font.name = "SF Mono";
  };
  
  imports = [
  ./terminal/options.nix
  ./terminal/default.nix
  ./shell.nix
  ./git.nix
  ./packages.nix
  ];
  
  home.activation.cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    DOTFILES_DIR="$HOME/dotfiles"
    if [ ! -d "$DOTFILES_DIR" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone \
        --depth=1 \
        https://github.com/stoic031/dotfiles \
        "$DOTFILES_DIR"
    else
      $VERBOSE_ECHO "Dotfiles already exist, skipping"
    fi
  '';


  home.activation.installTpm = lib.hm.dag.entryAfter ["writeBoundary"] ''
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone \
        --depth=1 \
        https://github.com/tmux-plugins/tpm \
        "$TPM_DIR"
    else
      $VERBOSE_ECHO "TPM already installed, skipping"
    fi
  '';
}
