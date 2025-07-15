{
  config,
  pkgs,
  inputs,
  ...
}: {
  xdg.configFile."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  home.sessionVariables = rec {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
    TLDR_CACHE_DIR = config.xdg.cacheHome;
  };

  # disable man pages
  manual.manpages.enable = false;

  services.lorri.enable = true;
}
