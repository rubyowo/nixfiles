{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    defaultEditor = true;
    enable = true;
    settings = lib.importTOML ../confs/helix/config.toml;
  };

  xdg.configFile."helix/themes/catppuccin_mocha.toml".source = ../confs/helix/themes/catppuccin-mocha.toml;
}
