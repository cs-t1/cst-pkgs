{
  pkgs ? (import <nixpkgs> { }),
}:
import pkgs.path { overlays = pkgs.overlays ++ [ (import ./overlay.nix) ]; }

