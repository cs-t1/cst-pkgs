{
  description = "cst1's packages";

  # Externally extensible flake systems. See <https://github.com/nix-systems/nix-systems>.
  inputs.systems.url = "github:nix-systems/default";

  outputs = { self, systems }: {
    pkgs = import ./default.nix {};
  };
}
