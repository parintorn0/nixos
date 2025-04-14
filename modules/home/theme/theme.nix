{ pkgs, config, ... }:
let
  vimixCursorTheme = {
    name = "Vimix-Cursors";
    package = pkgs.vimix-cursor-theme;
    size = 40;
  };
  orchis-theme = pkgs.callPackage ./orchis-theme {
    theme = "pink";
    color = "dark";
    icon = "nixos";
    tweaks = ["macos"];
  };
in
{
  programs.gnome-shell = {
    enable = true;
    theme = {
      name = "Orchis-Pink-Dark";
      package = orchis-theme;
    };
    extensions = [
      { package = pkgs.gnomeExtensions.dash-to-dock; }
      { package = pkgs.gnomeExtensions.blur-my-shell; }
      { package = pkgs.gnomeExtensions.appindicator; }
      { package = pkgs.gnomeExtensions.astra-monitor; }
    ];
  };
  gtk = {
    enable = true;
    cursorTheme = vimixCursorTheme;
    theme = {
      name = "Orchis-Pink-Dark";
      package = orchis-theme;
    };
    iconTheme = {
      name = "Tela-circle-pink-dark";
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = ["pink"];
      };
    };
  };
  
  home.pointerCursor = vimixCursorTheme // {
    enable = true;
  };
}
