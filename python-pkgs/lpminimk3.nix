{ lib
, pkgs
, stdenv
, setuptoolsBuildHook
, buildPythonPackage
, pythonPackages
, fetchFromGitHub
, fetchPypi
, python-rtmidi
, jsonschema
, websockets
}:
let
  attrs = {
    pname = "lpminimk3";
    version = "0.6.2";
    # TODO: inherit
    src = fetchPypi {
      pname = "lpminimk3";
      version = "0.6.2";
      sha256 = "sha256-oLMf0I15jfkoZxfZ6dgp1NxMBaekvV4B1RUWJhpmy8g=";
    };
    doCheck = false;
    propagatedBuildInputs = [
      # Specify dependencies
      python-rtmidi
      jsonschema
      websockets
    ];
  };
in
buildPythonPackage attrs
