{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.username = "andy";
  home.homeDirectory = "/Users/andy";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  myConfig = {
    terminal = "ghostty";
    opacity = 0.95;
    theme = "TokyoNight";
    font.name = "SF Mono";
  };

  imports = [
    ./terminal/options.nix
    ./terminal/default.nix
    ./shell.nix
    ./git.nix
    ./packages.nix
  ];

  home.activation.runSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.git}/bin:${pkgs.stow}/bin:${pkgs.bash}/bin:$PATH"
    $DRY_RUN_CMD ${pkgs.bash}/bin/bash ${../scripts/setup.sh}
  '';

}
