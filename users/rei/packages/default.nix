{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    lazygit
    lazydocker
    zsh
    starship
    cachix
    direnv

    # i am coping
    nodejs_latest

    docker-compose
    docker-buildx
    kubectl
    k9s

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
