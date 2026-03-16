#!/bin/bash
set -e

make clean
make

rm -rf deb_pkg
mkdir -p deb_pkg/DEBIAN
mkdir -p deb_pkg/usr/local/bin

cp matrix_variant9 deb_pkg/usr/local/bin/

cat > deb_pkg/DEBIAN/control <<EOF
Package: matrix-variant9
Version: 1.0-1
Section: utils
Priority: optional
Architecture: amd64
Depends: libc6, libstdc++6
Maintainer: Ilya <o726b09@voenmeh.ru>
Description: Sum of non-negative columns on diagonal.
EOF

dpkg-deb --build deb_pkg
mv deb_pkg.deb matrix_variant9_1.0-1_amd64.deb

echo "Package created: matrix_variant9_1.0-1_amd64.deb"
