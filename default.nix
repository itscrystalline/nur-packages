# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage
{pkgs ? import <nixpkgs> {}}: {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib {inherit pkgs;}; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  app2nix = pkgs.callPackage ./pkgs/app2unit {};
  occasion = pkgs.callPackage ./pkgs/occasion {};
  veridian = pkgs.callPackage ./pkgs/veridian {};
  sipa-th-fonts = pkgs.callPackage ./pkgs/sipa-th-fonts {};
  hass-localtuya = pkgs.callPackage ./pkgs/hass-localtuya {};
  ha_tuya_ble = pkgs.callPackage ./pkgs/ha_tuya_ble {};
  jitterbugpair = pkgs.callPackage ./pkgs/jitterbugpair {};
}
