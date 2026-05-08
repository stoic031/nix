{ pkgs, ... } : {
  home.packages = with pkgs; [
    ripgrep fd fzf jq awscli2 eza unzip zoxide delta dust
  ]++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ 
    mas 
 
  ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
    xclip htop
  ];



}
