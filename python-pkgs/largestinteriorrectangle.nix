{ lib
, pkgs
, stdenv
, setuptoolsBuildHook
, buildPythonPackage
, fetchFromGitHub
, opencv-python
, numba
, fetchPypi
, setuptools
, wheel
}:
let
  attrs = {
    pname = "largestinteriorrectangle";
    version = "0.2.1";
    # TODO: inherit
    src = fetchPypi {
      pname = "largestinteriorrectangle";
      version = "0.2.1";
      sha256 = "sha256-WTJPJZfMRiGwKbpcv3HYT4EloSkUpbtzENVvxJiwAr0=";
    };
    doCheck = false;
    dependencies = [
      # Specify dependencies
      opencv-python
      numba
    ];

    # specific to buildPythonPackage, see its reference
    pyproject = true;
    build-system = [
      setuptools
      wheel
    ];
  };
in
buildPythonPackage attrs
