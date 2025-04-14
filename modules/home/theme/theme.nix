{ pkgs, config, ... }:
let
  orchis-theme = {
    name = "Orchis-Pink-Dark-Compact";
      package = pkgs.callPackage ./orchis-theme {
      theme = "pink";
      color = "dark";
      size = "compact";
      icon = "nixos";
      tweaks = ["macos"];
    };
  };
  vimix-cursor-theme = {
    name = "Vimix-Cursors";
    package = pkgs.vimix-cursor-theme;
    size = 40;
  };
  tela-circle-icon-theme = {
    name = "Tela-circle-pink-dark";
    package = pkgs.tela-circle-icon-theme.override {
      colorVariants = ["pink"];
    };
  };
  
  selected-theme = orchis-theme;
  selected-cursor-theme = vimix-cursor-theme;
  selected-icon-theme = tela-circle-icon-theme;

in
{
  programs.gnome-shell = {
    enable = true;
    theme = selected-theme;
    extensions = [
      { package = pkgs.gnomeExtensions.dash-to-dock; }
      { package = pkgs.gnomeExtensions.blur-my-shell; }
      { package = pkgs.gnomeExtensions.appindicator; }
      { package = pkgs.gnomeExtensions.astra-monitor; }
    ];
  };
  gtk = {
    enable = true;
    theme = selected-theme;
    cursorTheme = selected-cursor-theme;
    iconTheme = selected-icon-theme;
  };
  
  home.pointerCursor = selected-cursor-theme // {
    enable = true;
  };
}
