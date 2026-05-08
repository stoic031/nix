{ pkgs, config, ... } : {
  # ── Zsh ──────────────────────────────────────────
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

  initContent = ''
  source ~/.zshrc
  '';
  };
  # ── Starship prompt ──────────────────────────────
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  xdg.configFile."starship.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink
    "~/.config/starship.toml";
  };

  # ── Direnv ───────────────────────────────────────
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;   
  };
  
  # ── Terminal tools ───────────────────────────────
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;    
  };

  programs.bat.enable = true;   







}
