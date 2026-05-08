{ pkgs, config, ... }:{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby      = false;
    withPython3   = false;

    extraPackages = with pkgs; [
      luajit          
      luarocks        
      lua-language-server
      jdt-language-server
    ];
  };
  
}
