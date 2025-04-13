{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "parintorn0";
    userEmail = "github@alias.toparin.me";
  };
}
