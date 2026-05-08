{ pkgs, config, lib, ... }:
let
  cfg = config.myConfig;
in {
  programs.ghostty = lib.mkIf (cfg.terminal == "ghostty") {
    enable  = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = {
      background-opacity = cfg.opacity;
    } // lib.optionalAttrs (cfg.font.name != null) {
      font-family = cfg.font.name;
    } // lib.optionalAttrs (cfg.font.size != null) {
      font-size = cfg.font.size;
    }; 


  };

}
