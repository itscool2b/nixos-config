# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
       inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
 # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #flakes line yay

 nix.settings.experimental-features = ["nix-command" "flakes"];

 #hyprland
  
  
  # Ricing  
    stylix = {
  enable = true;
  autoEnable = true;
  polarity = "dark";
  
 # Base16 Scheme (Fixed Syntax)
  base16Scheme = {
    base00 = "#151515";
  base01 = "#202020";
  base02 = "#303030";
  base03 = "#505050";
  base04 = "#b0b0b0";
  base05 = "#d0d0d0";
  base06 = "#e0e0e0";
  base07 = "#f5f5f5";
  base08 = "#fb9fb1";
  base09 = "#eda987";
  base0A = "#ddb26f";
  base0B = "#acc267";
  base0C = "#12cfc0";
  base0D = "#6fc2ef";
  base0E = "#e1a3ee";
  base0F = "#deaf8f";

  };

  fonts = {
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono NFM";
    };
    
    sizes = {
      terminal = 12;
      popups = 12;
    };
  };

  cursor.name = "BreezeX-RosePine-Linux";

  # Wallpaper handling (with proper builtins.path usage)
  image = builtins.path {
    path = ./wallpaper.png;
    name = "wallpaper.png";
  };
};  
    
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.interfaces.enp7s0.useDHCP = true;
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
 # services.xserver.enable = true;
  services.xserver = {
  enable = true;

  displayManager = {
    lightdm.enable = true;
    defaultSession = "xfce";
  };

  desktopManager = {
    xfce = {
      enable = true;
      noDesktop = true;        # Disable XFCE desktop icons and background handling
      enableXfwm = false;      # Disable XFCE window manager
    };
  };

  windowManager.i3.enable = true;
};

  # Enable the XFCE Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
    
 # Enable CUPS to print documents.
  services.printing.enable = true;
  #bluetooth support
  hardware.bluetooth.enable = true;


  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.itscool2b = {
    isNormalUser = true;
    description = "Arjun Bajpai";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

#gaming
hardware.nvidia.modesetting.enable = true;
services.xserver.videoDrivers = ["nvidia"];
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
programs.steam.gamescopeSession.enable = true;
programs.gamemode.enable = true;


home-manager = {
#specialArgs = {inherit inputs;};
users = {
"itscool2b" = import ./home.nix;
};
};  
  #un Install firefox.
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   git
   mangohud
  ];





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
  system.stateVersion = "24.11"; # Did you read the comment?

}
