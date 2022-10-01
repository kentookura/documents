{
  pkgs,
  inputs,
}: {
  makeTLpkg = name:
    pkgs.stdenv.mkDerivation {
      pname = "name";
      name = "name";
      src = ./texlivepkgs/${name}.sty;
      phases = ["installPhase"];
      installPhase = ''
        mkdir -p $out/tex/${name}
        cp $src $out/tex/${name}
      '';
      tlType = "run";
    };
}
