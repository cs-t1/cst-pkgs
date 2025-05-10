{ lib
, pkgs
, stdenv
, setuptoolsBuildHook
, buildPythonPackage
, pythonPackages
, fetchFromGitHub
, fetchPypi
, opencv-python
, requests
, setuptools
, wheel
, largestinteriorrectangle
}:
let
  attrs = {
    pname = "stitching";
    version = "0.6.1";
    # TODO: inherit
    src = fetchPypi {
      pname = "stitching";
      version = "0.6.1";
      sha256 = "sha256-UM71KqK/yPYV4SltULCFBjtLEDTqlfh7mfC52BVKzEU=";
    };
    doCheck = false;
    dependencies = [
      # Specify dependencies
      opencv-python
      requests
      largestinteriorrectangle
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
