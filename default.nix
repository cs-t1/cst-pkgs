{ pkgs, ... }:
{
  rvgl = pkgs.callPackage ./pkgs/rvgl-bin.nix { };
}
