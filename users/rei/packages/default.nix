{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    seatd
    lazygit
    lazydocker
    gparted
    gimp
    pavucontrol
    mako
    foot
    zsh
    starship
    dconf
    fontconfig
    neovim-unwrapped
    playerctl
    cachix
    cava
    swaylock-effects
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    winetricks
    # lutris
    # bottles
    zathura
    keepassxc
    (rust-bin.stable.latest.default.override {extensions = ["rust-src"];})
    rust-analyzer
    direnv
    mpd-mpris
    syncthing
    virt-manager
    gnome.seahorse
    libreoffice

    # i am coping
    nodejs_latest

    docker-compose
    docker-buildx

    inputs.catppuccin-toolbox.packages.${pkgs.system}.puccinier
    inputs.catppuccin-toolbox.packages.${pkgs.system}.catwalk
    inputs.catppuccin-toolbox.packages.${pkgs.system}.whiskers

    # Modern unix
    ripgrep
    mcfly
    fd
    duf
    eza
    bat
    jq
    tldr
    dogdns
    httpie
    curlie
  ];
}
