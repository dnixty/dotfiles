{ config, lib, pkgs, ... }:

with lib;
let
  shared = import ../../shared.nix;
in
{
  boot.cleanTmpDir = true;
  system.stateVersion = "20.03";
  i18n.defaultLocale = "en_GB.UTF-8";
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
  users.users.dnixty = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    group = "users";
    home = "/home/dnixty";
    extraGroups = [ "wheel" "input"]
                  ++ optionals config.services.xserver.enable ["audio" "video" "lp" "networkmanager"];
    openssh.authorizedKeys.keys = shared.ssh_keys;
  };
  environment.systemPackages = with pkgs; [];
}
