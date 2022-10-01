{
  description = "LaTeX Document Demo";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    tl = nixpkgs.legacyPackages.${system}.texlive;

    makeTLpkg = name:
      pkgs.stdenvNoCC.mkDerivation {
        name = name;
        pname = name;
        src = ./texlivepkgs;
        dontConfigure = true;
        tlType = "run";
        phases = ["installPhase"];
        nativeBuildInputs = [tl.combined.scheme-small];
        installPhase = ''
          mkdir -p $out/tex/latex
          cp $src/${name}.sty $out/tex/latex
        '';
      };

    operators = {pkgs = [(makeTLpkg "operators")];};
    quiver = {pkgs = [(makeTLpkg "quiver")];};
    preamble = {pkgs = [(makeTLpkg "preamble")];};

    tex = tl.combine {
      inherit
        (tl)
        tikz-cd
        scheme-medium
        etoolbox
        import
        latex-bin
        memoir
        platex-tools
        biblatex
        amsfonts
        amsmath
        amstex
        titlesec
        hyperref
        hycolor
        geometry
        nth
        mathtools
        extpfeil
        lipsum
        floatrow
        caption
        titling
        pgfplots
        asymptote
        bussproofs
        ;
      inherit
        operators
        quiver
        preamble
        ;
    };
    #frontpage = makeTLpkg "frontpage";

    config = {
      pname = "Kento_Okura_Bsc_Thesis_2022";
      title = ''The Geometry and Logic of the \\'Etale Site'';
      author = "Kento Okura";
      root_dir = ./thesis;
      root_file = "main.tex";
      advisor = "Ivan Di Liberti (Stockholm University)";
      degree_code = "A 033621";
      date = "Wien, im Monat September 2022";
      field = "Mathematik";
    };

    document = {
      pname,
      root_dir,
      ...
    }:
      pkgs.stdenvNoCC.mkDerivation rec {
        src = root_dir;
        name = pname;
        builder = "${pkgs.bash}/bin/bash";
        args = [./builder.sh];
        buildInputs = [pkgs.coreutils pkgs.latexrun tex pkgs.bash];
        phases = ["buildPhase" "installPhase"];
        TITLEPAGE = import ./titlepage.nix {config = config;};
      };
  in {
    devShells.x86_64-linux.default = import ./shell.nix {inherit pkgs config;};
    packages.x86_64-linux.titlePage = pkgs.writeTextFile {
      name = "titlePage";
      text = builtins.readFile ./titlepage.tex;
    };
    packages.x86_64-linux.default = document {
      pname = "test";
      root_dir = ./src;
    };
    packages.x86_64-linux.kento = document {
      pname = config.pname;
      root_dir = config.root_dir;
    };
  };
}
