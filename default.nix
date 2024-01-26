{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "impbcopy";
  version = "1.0";

  src = ./.;

  buildInputs =
    [ pkgs.clang ] ++
    (with pkgs.darwin.apple_sdk.frameworks; [ Foundation AppKit Cocoa ]);

  buildPhase = ''
    clang -Wall -O2 -ObjC \
      -framework Foundation -framework AppKit \
      -o impbcopy impbcopy.m
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp impbcopy $out/bin/
  '';

  meta = with pkgs.lib; {
    description = "A command-line tool to copy images to the clipboard";
    platforms = platforms.darwin;
  };
}
