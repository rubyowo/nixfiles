{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = false;
    settings = lib.importTOML ../confs/starship.toml;
  };
}
