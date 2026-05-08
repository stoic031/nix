# home/git.nix
{ pkgs, ... }: {
  programs.delta = {
    enable                = true;
    enableGitIntegration  = true;   
    options = {
      navigate     = true;
      side-by-side = true;
      line-numbers = true;
    };
  };

  programs.git = {
    enable  = true;
    ignores = [ ".DS_Store" ".direnv" ".envrc" "*.swp" ".idea/" ];

    settings = {
      user = {
        name  = "Andy Nguyen";   # ← thay userName
        email = "theanh.nguyen.nt031@gmail.com";   
      };

      alias = {                      
        st   = "status";
        co   = "checkout";
        br   = "branch";
        lg   = "log --oneline --graph --decorate";
        undo = "reset HEAD~1 --mixed";
      };

      init.defaultBranch    = "main";
      pull.rebase           = true;
      push.autoSetupRemote  = true;
      core.editor           = "nvim";
      core.autocrlf         = "input";
    };
  };

  home.packages = [ pkgs.delta ];
}
