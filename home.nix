{ config, pkgs, ... }:

{
  home.username = "kirin";
  home.homeDirectory = "/home/kirin";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.docker
    pkgs.nvidia-container-toolkit
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "kirinrastogi";
      email = "14277509+kirinrastogi@users.noreply.github.com";
    };
  };

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
