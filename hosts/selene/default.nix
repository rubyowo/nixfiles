{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./hardware.nix ../common ../../users/rei];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {enable = true;};
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    tmp.cleanOnBoot = true;
    kernel.sysctl = {
      "net.ipv4.ip_forward" = true;
      "net.ipv6.conf.all.forwarding" = true;
      "net.ipv4.ip_unprivileged_port_start" = 0;
      "net.core.rmem_max" = 7500000;
      "net.core.wmem_max" = 7500000;
    };

    # supportedFilesystems = ["zfs"];
    # zfs.forceImportAll = false;
    # zfs.forceImportRoot = false;
  };

  # Configure nix itself
  nix = {
    package = pkgs.lix;
    settings = {
      # Experimental Features
      experimental-features = ["nix-command" "flakes"];

      # Maximum number of concurrent tasks during one build
      cores = 4;

      max-jobs = 16;

      # Perform builds in a sandboxed environment
      sandbox = true;

      # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy.
      auto-optimise-store = true;

      substituters = ["https://nix-community.cachix.org" "https://catppuccin.cachix.org"];
      trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="];

      #      use-xdg-base-directories = true;
    };
  };

  networking = {
    hostName = "selene";
    #hostId = "301af4f1";
    nameservers = ["127.0.0.1"];
  };

  services.dnsmasq = {
    enable = false;
    settings = {
      interface = "docker0";
      bind-interfaces = true;
      except-interface = "lo";
      port = 5353;
      server = ["192.168.32.5"];
      # server = ["1.1.1.1"]
      address = ["/whoison.top/192.168.96.23"];
    };
  };

  # ZFS
  # fileSystems."/storage/k3s" = {
  #   device = "zserver/k3s";
  #   fsType = "zfs";
  # };
  #
  # fileSystems."/server/other" = {
  #   device = "zserver/other";
  #   fsType = "zfs";
  # };

  # services.zfs = {
  #   autoScrub.enable = true;
  #   autoSnapshot.enable = true;
  # };

  # what the FUCK. nixos/nixpkgs#180175
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  # Time Zone/Locale
  time.timeZone = "Asia/Dubai";
  i18n.defaultLocale = "en_US.UTF-8";

  # systemd-journald
  services.journald.extraConfig = "MaxRetentionSec=1d";

  programs.zsh.enable = true;

  # Polkit
  security.polkit.enable = true;

  # Doas
  security.sudo.enable = true;

  # OpenSSH
  services.openssh = {
    enable = true;
  };

  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent  yes
    '';
  };

  # Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  services.samba-wsdd = {
    # make shares visible for Windows clients
    enable = true;
    openFirewall = true;
  };
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "server string" = "selene";
        "disable netbios" = true;
        "hosts allow" = ["192.168." "127." "localhost" "100."];
        "inherit permissions" = true;
        "guest account" = "rei";
      };
      games = {
        path = "/home/rei/network/roms";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "browsable" = "yes";
        "create mask" = "0664";
        "directory mask" = "0777";
        "force user" = "rei";
        "force group" = "users";
      };
      public = {
        path = "/export";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "browsable" = "yes";
        "create mask" = "0664";
        "directory mask" = "0777";
        "force user" = "rei";
        "force group" = "users";
      };
    };
  };

  # Syncthing
  services.syncthing = {
    enable = false;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    relay.enable = true;
    # settings.options = {
    #   localAnnounceEnabled = true;
    #   relaysEnabled = true;
    # };
  };

  # auto-cpufreq
  programs.auto-cpufreq.enable = true;

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
  };

  # GNOME Keyring
  services.gnome.gnome-keyring.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      experimental = true;
      # ipv6 = true;
      # dns = "172.17.0.1";
      # dns = ["1.1.1.1"];
    };
  };

  # k3s
  services.k3s = {
    enable = false;
    role = "server";
    clusterInit = true;
  };

  # QEMU
  # virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;

  services.avahi = {
    enable = true;
    openFirewall = true;
    nssmdns4 = true;
  };

  # Allow unfree and insecure packages. Heh insecure, like me.
  # Okay i don't do that anymore (allow insecure packages) but im still leaving the comment in :^)
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Disable documentation packages
  documentation = {
    enable = false;
    doc.enable = false;
    info.enable = false;
    man.enable = false;
  };

  # Fonts
  # fonts = {
  #   packages = with pkgs; [
  #     twemoji-color-font
  #     noto-fonts
  #     noto-fonts-cjk
  #     noto-fonts-emoji
  #     (nerdfonts.override {fonts = ["FantasqueSansMono"];})
  #   ];
  #
  #   fontconfig = {
  #     defaultFonts = {
  #       monospace = [
  #         "FantasqueSansM Nerd Font Mono"
  #         "Noto Color Emoji"
  #       ];
  #       sansSerif = ["Noto Sans" "Noto Color Emoji"];
  #       serif = ["Noto Serif" "Noto Color Emoji"];
  #       emoji = ["Noto Color Emoji"];
  #     };
  #   };
  # };

  system.stateVersion = "22.05";
}
