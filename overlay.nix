final: prev:
let
  inherit (prev.lib)
    mapAttrs'
    removeSuffix
    ;
  mkGeneralOverlay =
    dir: self: super:
    mapAttrs' (name: _: {
      value = self.callPackage (dir + "/${name}") { };
      name = removeSuffix ".nix" name;
    }) (builtins.readDir dir);
in
mkGeneralOverlay ./pkgs final prev
// {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [ (mkGeneralOverlay ./python-pkgs) ];
}

