{
  description = "cst1's packages";

  # Externally extensible flake systems. See <https://github.com/nix-systems/nix-systems>.
  inputs.systems.url = "github:nix-systems/default";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, systems, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem
      (system:
        {
          pkgs = import ./default.nix { pkgs = (import nixpkgs { }); };
        }
        );
}
