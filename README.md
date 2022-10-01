# Requirements
You need to have the nix package manager and direnv installed. As flakes are
still an experimental feature, you need to enable flakes after installing nix.
see [here](https://nixos.wiki/wiki/Flakes) on how to do this.

# The flake structure

At the moment the inputs are just nixpkgs and flake-utils. The 'tex' definition
in the let binding allows us to basically construct our custom latex distribution.

# direnv and the nix shell

Direnv allows us to load a custom shell environment upon entering this
directory. This allows us to define shell scripts, environment variables and to
load packages to work with our document. I have included a language server, a
texlive distribution and the document converter pandoc for now.



