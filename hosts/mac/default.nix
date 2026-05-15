{ pkgs, ... }:
{

  networking.hostName = "andy";
  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs.config.allowUnfree = true;
  nix.enable = false;
  system.primaryUser = "andy";

  users.users.andy = {
    name = "andy";
    home = "/Users/andy";
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  system.defaults = {
    dock = {
      autohide = true;
    };
    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
    };
    CustomUserPreferences = {
      "org.hammerspoon.Hammerspoon" = {
        MJConfigFile = "~/.config/hammerspoon/init.lua";
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    casks = [ "hammerspoon" ];
  };

  system.stateVersion = 5;

}
