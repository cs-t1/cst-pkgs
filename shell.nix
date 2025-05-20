let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs { };
in

pkgs.mkShellNoCC {
  packages = [
    (pkgs.callPackage ./pkgs/rvgl-bin.nix {})
  ];
}
