{ pkgs, ... }: {
  
  networking.hostName = "andy";
  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs.config.allowUnfree = true;
  nix.enable = false;
  system.primaryUser = "andy";
  
  users.users.andy = {
    name  = "andy";
    home  = "/Users/andy";
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
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";  
    };
  };

  system.stateVersion = 5;


}
