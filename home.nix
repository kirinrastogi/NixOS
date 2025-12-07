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
    pkgs.cudaPackages.cudatoolkit
    pkgs.ripgrep
    pkgs.fd
    pkgs.fzf
    pkgs.ollama-cuda
    pkgs.git-lfs
    pkgs.uv
    pkgs.bat
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "kirinrastogi";
        email = "14277509+kirinrastogi@users.noreply.github.com";
      };
    };
    lfs.enable = true;
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
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      eval "$(direnv hook zsh)"
      source ~/.p10k.zsh
    '';
    plugins = [
      {
        name = "powerlevel10k";
	src = pkgs.zsh-powerlevel10k;
	file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.direnv.enable = true;

  programs.home-manager.enable = true;
}
