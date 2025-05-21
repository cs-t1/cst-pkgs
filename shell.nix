let
 pkgs= import <nixpkgs> { };
in

pkgs.mkShellNoCC {
  packages = [
    (pkgs.callPackage ./pkgs/rvgl-bin.nix {})
  ];
}
