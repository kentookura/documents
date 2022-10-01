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
    texLive = import ./texlive.nix {
      inherit
        pkgs
        inputs
        system
        ;
    };
    document = import ./document.nix {inherit pkgs texLive;};
  in {
    devShells.x86_64-linux.default = import ./shell.nix {inherit pkgs;};
    packages.x86_64-linux.default = document.build {
      name = "Test_File_Name";
      title = ''My Grand Tehsis'';
      author = "Kento Okura";
      root_dir = ./src;
      root_file = "main.tex";
      advisor = "Ivan Di Liberti (Stockholm University)";
      degree_code = "A 033621";
      date = "Wien, im Monat September 2022";
      field = "Mathematik";
    };
    #packages.x86_64-linux.kento = document.build {inherit config;};
  };
}
