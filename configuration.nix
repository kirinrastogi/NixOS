{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  time.hardwareClockInLocalTime = true;

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 38 * 1024;
    randomEncryption.enable = true;
    options = [ "discard" ];
  }];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  hardware.graphics = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    resolutions = [
      { x = 3840; y = 2160; }
      { x = 1920; y = 1080; }
    ];
    windowManager = {
      qtile.enable = true;
    };
    displayManager = {
      setupCommands = ''
        /run/current-system/sw/bin/xrandr --output DP-0 --primary --auto
        /run/current-system/sw/bin/xrandr --output HDMI-0 --auto --right-of DP-0
      '';
      lightdm = {
        enable = true;
      };
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  programs.zsh.enable = true;

  users.users.kirin = {
    isNormalUser = true;
    description = "kirin";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     alacritty
     neovim
     btop
     git
     fastfetchMinimal
     wget
     xclip
     xorg.xrandr
     pavucontrol
     zsh
     docker
     nvidia-docker
  ];

  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;

  boot.kernelModules = [
    "nvidia"
    "nvidia-modeset"
    "nvidia-drm"
    "nvidia-uvm"
  ];

  environment.variables = {
    NVIDIA_VISIBLE_DEVICES = "all"; # Use all GPUs; change as needed
    NVIDIA_DRIVER_CAPABILITIES = "compute,utility"; # Configure based on needs
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
