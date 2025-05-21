{ nixpkgs, ... }:
{
  rvgl = nixpkgs.callPackage ./pkgs/rvgl-bin.nix { };
}
