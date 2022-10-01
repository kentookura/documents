{pkgs ? import <nixpkgs> {}}: let
  watch = pkgs.writeShellScriptBin "watch" ''
    latexmk -pdf -pvc main.tex -outdir=result
  '';
  clean = pkgs.writeShellScriptBin "clean" ''
    latexmk --outdir=result -C
    latexrun -O result --clean
  '';
  LATEXMKRC = ''
    \$pdf_previewer = 'zathura';
  '';
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      watch
      texlive.combined.scheme-full
      texlab
      latexrun
      pandoc
    ];
    shellHook = ''
    '';
  }
