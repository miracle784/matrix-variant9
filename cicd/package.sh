#!/bin/bash
set -e

echo "=== PACKAGE STAGE ==="

BUILD_DIR="matrix-variant9_1.0-1_amd64"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/usr/local/bin"

cp DEBIAN/control "$BUILD_DIR/DEBIAN/"
cp src/matrix_variant9 "$BUILD_DIR/usr/local/bin/"

dpkg-deb --build "$BUILD_DIR"

echo "Готовый пакет:"
ls -l *.deb
