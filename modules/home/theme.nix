{ pkgs, ... }:
{
  programs.gnome-shell = {
    enable = true;
    theme = {
      name = "Orchis-Pink-Dark-Compact";
      package = pkgs.orchis-theme.override {
        tweaks = ["macos"];
      };
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
    cursorTheme = {
      name = "Adwaita";
    };
    theme = {
      name = "Orchis-Pink-Dark-Compact";
      package = pkgs.orchis-theme.override {
        tweaks = ["macos"];
      };
    };
    iconTheme = {
      name = "Tela-circle-pink-dark";
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = ["pink"];
      };
    };
  };
}
