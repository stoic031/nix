{ pkgs, config, ... } : {
  # ── Zsh ──────────────────────────────────────────
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size       = 10000;
      save       = 10000;
      ignoreDups = true;
      share      = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    
    shellAliases = {
        rebuild = "sudo darwin-rebuild switch --flake ~/.config/nix#Andys-MacBook-Pro";
        gcn     = "nix-collect-garbage -d";

        g       = "git";
        gs      = "git status";
        ga      = "git add";
        gcm     = "git commit";
        gcl     = "git clone";
        gp      = "git push";
        gl      = "git log --oneline --graph --decorate";

        ".."    = "cd ..";
        "..."   = "cd ../..";
        v     = "nvim";
        vim   = "nvim";
        nixcfg = "nvim ~/.config/nix/";
        nvimcfg = "nvim ~/.config/nvim";
        


        ls  = "eza --color=always --group-directories-first --icons";
        ll  = "eza -la --icons --group-directories-first";
        l   = "eza -lbF --git --icons --group-directories-first";
        la  = "eza --long --all --group --group-directories-first";

        lt  = "eza --tree --level=2 --icons --color=always";
        lt3 = "eza --tree --level=3 --icons --color=always";
        lm  = "eza -lbGd --git --sort=modified --icons";

        find = "fd";
        fdf  = "fd -t f";
        fdd  = "fd -t d";

        fcd   = "cd \$(fd -t d | fzf)";
        fcat = "bat \$(fd -t f | fzf)";




      };

    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv zsh)"
      
      export STARSHIP_CONFIG="$HOME/.config/starship.toml"
      eval "$(starship init zsh)"

      eval "$(zoxide init zsh --cmd cd)"
      function zitree() {
  local dir
  dir=$(zoxide query -ls | awk '{print $2}' | \
    fzf --preview 'eza -T --color=always {} 2>/dev/null' \
        --preview-window=right:60% \
        --height=70%)
  [[ -n "$dir" ]] && cd "$dir"
};
      source <(fzf --zsh)
    '';
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
