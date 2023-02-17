{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  users.users.rei = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  environment = {
    shells = [pkgs.zsh];

    systemPackages = with pkgs; [
      git
      wget
      home-manager
      pipewire
      wireplumber
      pulseaudio
      zsh
      unzip
      gnupg
    ];

    pathsToLink = ["/share/zsh"];
  };

  home-manager.users.rei = {
    home = rec {
      inherit (config.system) stateVersion;
      username = "rei";
      homeDirectory = "/home/${username}";
    };

    _module.args = {inherit inputs;};

    imports = [
      inputs.hyprland.homeManagerModules.default

      ./env.nix
      ./apps
      ./packages
    ];
  };
}
