{ config, pkgs, ... }:

{
  home.username = "kirin";
  home.homeDirectory = "/home/kirin";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.docker
    pkgs.nvidia-container-toolkit
    pkgs.vlc
    pkgs.zsh-powerlevel10k
    pkgs.oh-my-zsh
    #pkgs.nerd-fonts-complete
    pkgs.cudaPackages.cudatoolkit
    pkgs.ripgrep
    pkgs.fd
    pkgs.fzf
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "kirinrastogi";
      email = "14277509+kirinrastogi@users.noreply.github.com";
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ntest = "sudo nixos-rebuild test --flake /home/kirin/nixos";
      nswitch = "sudo nixos-rebuild switch --flake /home/kirin/nixos";
      hswitch = "home-manager switch --flake /home/kirin/nixos";
    };
    history.size = 10000;
    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      eval "$(direnv hook zsh)"
    '';
  };

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.direnv.enable = true;

  programs.home-manager.enable = true;
}
