{ config, lib, ... }:

let
  cfg = config.services.myNextDNS;
in {
  options.services.myNextDNS = {
    enable = lib.mkEnableOption "Custom NextDNS configuration";
    
    nextdnsId = lib.mkOption {
      type = lib.types.str;
      description = "NextDNS configuration ID";
    };
  };

  config = lib.mkIf cfg.enable {
    services.resolved = {
      enable = true;
      extraConfig = ''
        [Resolve]
        DNS=45.90.28.0#${cfg.nextdnsId}.dns.nextdns.io
        DNS=2a07:a8c0::#${cfg.nextdnsId}.dns.nextdns.io
        DNS=45.90.30.0#${cfg.nextdnsId}.dns.nextdns.io
        DNS=2a07:a8c1::#${cfg.nextdnsId}.dns.nextdns.io
        DNSOverTLS=yes
      '';
    };
  };
}
