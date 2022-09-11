{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [
    pkgs.hello
    pkgs.latexrun

    # keep this line if you use bash
    pkgs.bashInteractive
  ];
}
