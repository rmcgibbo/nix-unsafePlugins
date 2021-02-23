{stdenv
, pkg-config
, cmake
, nlohmann_json
, nixUnstable
, boost
}:

stdenv.mkDerivation {
    pname = "traceFd";

    version = "0";
    src = ./.;

    nativeBuildInputs = [ cmake pkg-config ];
    buildInputs = [
        nixUnstable
        nlohmann_json
        boost
    ];
}

