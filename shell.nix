with import <nixpkgs> { };
let gtk = gtk3;
in mkShell {
  buildInputs = [ flutter gtk pkg-config ];
  shellHook = ''
    export PKG_CONFIG_PATH="${gtk.dev}/lib/pkgconfig:${gtk.out}/lib/pkgconfig"
  '';
}
