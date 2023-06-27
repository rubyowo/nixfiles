{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [libsixel];
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${config.xdg.configHome}/foot/mocha.ini";
        font = "FantasqueSansM Nerd Font Mono :size=10:style=Regular";
        font-bold = "FantasqueSansM Nerd Font Mono:size=10:style=Bold";
        font-italic = "FantasqueSansM Nerd Font Mono:size=10:style=Italic";
        font-bold-italic = "FantasqueSansM Nerd Font Mono:size=8:style=Bold Italic";
      };
      mouse.hide-when-typing = "yes";
    };
  };
  xdg.configFile."foot/mocha.ini".text =
    builtins.readFile ../confs/foot/mocha.ini;
}
