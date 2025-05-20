{ lib
, pkgs
, stdenv
, fetchFromGitLab
, SDL2
, SDL2_image
, openal
, enet
, libunistring
, makeWrapper
}:

stdenv.mkDerivation (finalAttrs: rec {
  pname = "rvgl-bin";
  version = "";

  preferLocalBuild = true;
  dontBuild = true;

  # TODO: desktopitem
  #       c.f. https://github.com/NixOS/nixpkgs/blob/e06158e58f3adee28b139e9c2bcfcc41f8625b46/pkgs/by-name/fa/factorio/package.nix#L84

  sourceRoot = ".";

  nativeBuildInputs = [ makeWrapper ];

  srcs = [
     (fetchFromGitLab rec {
        name = repo;
        owner = "re-volt";
        repo = "game_files";
        rev = "22.0909";
        hash = "sha256-pX/bxesie6+Pw6A/T8Mn38kMIV89oyxFcKPgBxfw0zg=";
    })

    (fetchFromGitLab rec {
      name = repo;
      owner = "re-volt";
      repo = "rvgl-assets";
      rev = "23.1030a1";
      hash = "sha256-9CARqvRS2+r9T+s3uWE7PZLiPluypH8eOOUEGr9S8UQ=";
    })

    (fetchFromGitLab rec {
      name = repo;
      owner = "re-volt";
      repo = "rvgl-platform";
      rev = "23.1030a1";
      hash = "sha256-OlCNBUbyu/hA75qk27xSldjKXsPyaGLXxthtogdmfkQ=";
    })
  ];


  installPhase = ''
    #echo "$PWD"
    #ls -al
    #ls -al $srcs
    mkdir -p $out/opt/rvgl
    cp -a rvgl-assets/ $out/opt/rvgl
    cp -a game_files/ $out/opt/rvgl
    cp -a rvgl-platform/linux/ $out/opt/rvgl

    cp -a rvgl-platform/linux/rvgl.64 $out/opt/rvgl/rvgl

    patchelf \
        --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
        $out/opt/rvgl/rvgl

    patchelf --replace-needed "libunistring.so.2" "libunistring.so.5" "$out/opt/rvgl/rvgl"

      wrapProgram $out/opt/rvgl/rvgl                                \
            --prefix LD_LIBRARY_PATH : $libPath \
    '';

    libPath = lib.makeLibraryPath [
      SDL2
      SDL2_image
      openal
      enet
      libunistring
    ];

  #out = [ ];

  meta = {
    maintainers = [ ];
  };

})
