{
  pkgs,
  config,
  ...
}: let
  astronvim = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "main";
    sha256 = "sha256-Q0foWUqjnWhLKGTq1Xooe+J95BfPL1aodcqaozoQMPQ=";
  };
in {
  xdg.configFile."nvim".source = astronvim;

  home.packages = with pkgs; [
    stylua
    nodePackages_latest.prettier
    black
    alejandra
    shfmt
    # rustfmt is provided by rust-overlay

    selene
    nodePackages_latest.eslint_d
    shellcheck
    statix

    lua-language-server
    nodePackages_latest.typescript-language-server
    deno
    nodePackages_latest.bash-language-server
    nodePackages_latest.pyright
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.dockerfile-language-server-nodejs
    rnix-lsp
    # rust-analyzer is provided by rust-overlay

    gcc
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
