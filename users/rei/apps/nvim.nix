{
  pkgs,
  config,
  ...
}: {
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/users/rei/confs/nvim";
    recursive = true;
  };

  home.packages = with pkgs; [
    tree-sitter

    stylua
    prettierd
    black
    alejandra
    shfmt
    # rustfmt is provided by rust-overlay

    selene
    nodePackages_latest.eslint
    shellcheck
    statix
    hadolint
    proselint

    lua-language-server
    nodePackages_latest.typescript-language-server
    deno
    nodePackages_latest.bash-language-server
    nodePackages_latest.pyright
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.dockerfile-language-server-nodejs
    nodePackages_latest.graphql
    nodePackages_latest.graphql-language-service-cli
    nodePackages.yaml-language-server
    docker-compose-language-service
    rnix-lsp
    taplo
    luaPackages.tl
    luaPackages.teal-language-server
    nil
    # rust-analyzer is provided by rust-overlay

    gcc
    gnumake
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = false;
    viAlias = false;
    vimdiffAlias = false;
    withRuby = false;
    withNodeJs = false;
    withPython3 = false;
  };
}
