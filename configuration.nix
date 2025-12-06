# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
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

  networking.hostName = "nixos"; # Define your hostname.
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
      lightdm.enable = true;
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

  services.autorandr = {
    enable = true;
    defaultTarget = "dual";

    profiles = {
      single = {
        fingerprint = {
          DP = "DP-0 00ffffffffffff001e6d57780bcd090009230104c5462778f95a15ad523faf250e5054210900d1c06140454081c001010101010101014dd000a0f0703e8030203500b9882100001a000000fd0c30a5ffffeb010a202020202020000000fc004c4720554c545241474541522b000000ff003530394e5446414a573331350a029f020335712309070783010000453f10040301e2006ae305c000e6060501734f01741a0000030330a500a073014f02a500000000000009ec00a0a0a0675030203500b9882100001a5a8780a070384d4030203500b9882100001a00000000000000000000000000000000000000000000000000000000000000000000000000001b701279030001000c3a1b500f000f700890784ebb0f000aa4140e0e07012300000003013c364a0284ff0e9f0007801f006f08700030000700d4080204ff0e9f0007801f006f089900440007006f4f0104ff0e9f0007801f006f086200290007000000000000000000000000000000000000000000000000000000000000009e90";
        };

	config = {
	  DP = {
	    enable = true;
	    primary = true;
	    position = "0x0";
	    rate = "165.06";
	    mode = "3840x2160";
	  };

	  HDMI = {
	    enable = false;
	    primary = false;
	    position = "3840x2160";
	    mode = "1920x1080";
	    rate = "60";
	  };
	};
      };

      dual = {
        fingerprint = {
          DP = "DP-0 00ffffffffffff001e6d57780bcd090009230104c5462778f95a15ad523faf250e5054210900d1c06140454081c001010101010101014dd000a0f0703e8030203500b9882100001a000000fd0c30a5ffffeb010a202020202020000000fc004c4720554c545241474541522b000000ff003530394e5446414a573331350a029f020335712309070783010000453f10040301e2006ae305c000e6060501734f01741a0000030330a500a073014f02a500000000000009ec00a0a0a0675030203500b9882100001a5a8780a070384d4030203500b9882100001a00000000000000000000000000000000000000000000000000000000000000000000000000001b701279030001000c3a1b500f000f700890784ebb0f000aa4140e0e07012300000003013c364a0284ff0e9f0007801f006f08700030000700d4080204ff0e9f0007801f006f089900440007006f4f0104ff0e9f0007801f006f086200290007000000000000000000000000000000000000000000000000000000000000009e90";

	  HDMI = "HDMI-0 00ffffffffffff0009d1327f45540000031a010380351e782e9de1a654549f260d5054a56b80d1c0317c4568457c6168617c953c3168023a801871382d40582c4500132a2100001e000000ff004431473039383832534c300a20000000fd0018780f8711000a202020202020000000fc0042656e5120584c323431315a0a017b020323f15090050403020111121314060715161f202309070765030c00100083010000023a801871382d40582c4500132a2100001f011d8018711c1620582c2500132a2100009f011d007251d01e206e285500132a2100001f8c0ad08a20e02d10103e9600132a210000190000000000000000000000000000000000000000c7";
        };

	config = {
	  DP = {
	    enable = true;
	    primary = true;
	    position = "0x0";
	    rate = "165";
	    mode = "3840x2160";
	  };

	  HDMI = {
	    enable = true;
	    primary = false;
	    position = "3840x2160";
	    mode = "1920x1080";
	    rate = "60";
	  };
	};
      };
    };
  };


  users.users.kirin = {
    isNormalUser = true;
    description = "kirin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     alacritty
     neovim
     btop
     git
     neofetch
     wget
     xclip
     cowsay
     autorandr
     xorg.xrandr
  ];

/*
  programs.git = {
    enable = true;
    user = {
      name = "Kirin Rastogi";
      email = "14277509+kirinrastogi@users.noreply.github.com";
    };
    config = {
      init = {
        defaultBranch = "main";
      };
    };
  };
*/

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
