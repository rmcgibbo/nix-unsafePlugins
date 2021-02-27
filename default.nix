{stdenv
, pkg-config
, cmake
, nlohmann_json
, nixUnstable
, nix
, boost
}:

stdenv.mkDerivation {
    pname = "nix-unsafePlugins";

    version = "0";
    src = ./.;

    nativeBuildInputs = [ cmake pkg-config ];
    buildInputs = [
        # nixUnstable
        nix
        nlohmann_json
        boost
    ];
}

