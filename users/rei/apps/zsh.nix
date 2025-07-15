# ZSH settings
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    dotDir = ".config/zsh";
    history.path = "${config.home.homeDirectory}/.config/zsh/.zsh_history";
    autocd = true;

    # Aliases
    shellAliases = {
      lg = "lazygit";
      nix-clean = "sudo nix-collect-garbage";
      nix-switch = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#selene";
      nix-rollback = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#selene --rollback";
      cop = "docker compose up -d";
      cod = "docker compose down";

      # Modern unix
      grep = "rg $@";
      find = "fd $@";
      df = "duf $@";
      ls = "eza --git --icons $@";
      cat = "bat $@";
      dig = "dog $@";
      curl = "curlie $@";
    };

    envExtra = ''
      export MCFLY_KEY_SCHEME=vim
      export MCFLY_DISABLE_MENU=TRUE
    '';

    initExtra = ''
      eval "$(mcfly init zsh)"
      eval "$(direnv hook zsh)"
    '';

    plugins = [
      {
        name = "zsh-defer";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "zsh-defer";
          rev = "master";
          sha256 = "/rcIS2AbTyGw2HjsLPkHtt50c2CrtAFDnLuV5wsHcLc=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        src = pkgs.zsh-nix-shell;
      }
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
      {
        name = "catppuccin-zsh-syntax-hightlighting";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "dbb1ec93b30dbe8cd728cffe0974aa7fa1ac3298";
          sha256 = "0B7g0J6+ZCoe1eErsSEmqO0aNOBi+FB+///vXnuiels=";
        };
        file = "themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        src = pkgs.zsh-syntax-highlighting;
      }
    ];
  };
  home.packages = with pkgs; [
    zsh-nix-shell
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}
