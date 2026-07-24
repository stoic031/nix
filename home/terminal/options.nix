# home/options.nix
{ lib, ... }: {
  options.myConfig = {
    terminal = lib.mkOption {
      type = lib.types.enum [ "ghostty" "wezterm" "kitty" "alacritty" ];
      default = "ghostty";
      description = "Terminal emulator to use";
    };

    font = {
      name = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Font family name";
      };
      size = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "Font size in points";
      };
    };

    theme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Color theme name";
    };

    opacity = lib.mkOption {
      type = lib.types.float;
      default = 0.95;
      description = "Background opacity (0.0-1.0)";
    };
  };
}
