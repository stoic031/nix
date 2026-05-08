# home/options.nix
{ lib, ... }: {
  options.myConfig = {
    terminal = lib.mkOption {
      type    = lib.types.enum [ "ghostty" "wezterm" "kitty" "alacritty" ];
      default = "ghostty";
    };

    font = {
      name = lib.mkOption {
        type    = lib.types.nullOr lib.types.str;
        default = null; 
      };
      size = lib.mkOption {
        type    = lib.types.nullOr lib.types.int; 
        default = null;
      };
    };

    opacity = lib.mkOption {
      type    = lib.types.float;
      default = 0.95;
    };
  };
}
