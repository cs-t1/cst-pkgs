{ lib
, pkgs
, stdenv
, fetchFromGitLab
, flac
, SDL2
, SDL2_image
, openal
, enet
, libunistring
, makeWrapper
}:
let car_skins = true;
    additional_cars = true;
    additional_tracks = true;
    bonus_tracks = true;
in
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

    (fetchFromGitLab rec {
      name = repo;
      owner = "re-volt";
      repo = "rvio/cars";
      rev = "25.0414";
      hash = "sha256-/BkBwzwRwAorz4FghCCN7R8E7cbWwrQqNAbz0e0gcYk=";
    })]

    # skins
    ++ (lib.optional car_skins [

      (fetchFromGitLab rec {
        name = repo;
        owner = "re-volt";
        repo = "rvio/skins";
        rev = "25.0414";
        hash = "sha256-rsRcsTy3tAUgf8BrVPceTA/S7jfaFiJn2XyvIkTkttg=";
      })
    ])

    # bonus cars
    ++ (lib.optional additional_cars [

      (fetchFromGitLab rec {
        name = repo;
        owner = "re-volt";
        repo = "rvio/bonus_cars";
        rev = "25.0414";
        hash = "sha256-tf39G4MAGRWmnTx5k4RV69BwqtsBnjqe2BJrRA1SXZk=";
      })

      (fetchFromGitLab rec {
        name = repo;
        owner = "re-volt";
        repo = "rvio/bonus_skins";
        rev = "25.0414";
        hash = "sha256-hOBXFahGuOx1upoUngrvIBFWs+a7EJq35usAzLt8O3s=";
      })
    ])

    # tracks
    ++ (lib.optional additional_tracks [

      (fetchFromGitLab rec {
        name = repo;
        owner = "re-volt";
        repo = "rvio/tracks";
        rev = "25.0414";
        hash = "sha256-7Ex2p9/3kZ5vpQTNwsvmd33ehRKQZUVXfvmePcPP0N0=";
      })
    ])

    # bonus tracks
    ++ (lib.optional bonus_tracks [
      (fetchFromGitLab rec {
        name = repo;
        owner = "re-volt";
        repo = "rvio/bonus_tracks";
        rev = "25.0414";
        hash = "sha256-RRBinXyRJ9nOPLBNexo6D89qXXy0yjZjB2cPrTI4vqI=";
      })
    ])
  ;


  # TODO: adapt wrt flags
  installPhase = ''
    #echo "$PWD"
    ls -al
    #ls -al $srcs
    mkdir -p $out/opt/rvgl
    cp -R rvgl-assets/* $out/opt/rvgl
    cp -R game_files/* $out/opt/rvgl
    cp -a rvgl-platform/linux/ $out/opt/rvgl
    cp -R rvio-cars/* $out/opt/rvgl
    cp -R rvio-skins/* $out/opt/rvgl
    cp -R rvio-bonus_cars/* $out/opt/rvgl
    cp -R rvio-bonus_skins/* $out/opt/rvgl
    cp -R rvio-tracks/* $out/opt/rvgl
    cp -R rvio-bonus_tracks/* $out/opt/rvgl

    cp -a rvgl-platform/linux/rvgl.64 $out/opt/rvgl/rvgl

    patchelf \
        --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
        $out/opt/rvgl/rvgl

    patchelf --replace-needed "libunistring.so.2" "libunistring.so.5" "$out/opt/rvgl/rvgl"

    patchelf --set-rpath $out/opt: "$out/opt/rvgl/rvgl"

      wrapProgram $out/opt/rvgl/rvgl                                \
            --prefix LD_LIBRARY_PATH : $libPath \
    '';

    libPath = lib.makeLibraryPath [
      flac
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
