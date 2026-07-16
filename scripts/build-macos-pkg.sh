#!/bin/bash
# build-macos-pkg.sh - Builds a macOS installer package containing Servverse binaries.
set -e

VERSION="1.7.0"
IDENTIFIER="com.yuvaraj.servverse"
PKG_DIR="dist/macos-pkg"
BIN_DIR="${PKG_DIR}/usr/local/bin"

echo "Preparing package workspace..."
mkdir -p "${BIN_DIR}"

# Download and extract macOS production binaries from the tag release
tag="${GITHUB_REF_NAME}"
echo "Downloading servverse-${tag}-darwin-amd64.tar.gz..."
gh release download "${tag}" -p "servverse-${tag}-darwin-amd64.tar.gz" --dir dist
tar -xzf "dist/servverse-${tag}-darwin-amd64.tar.gz" -C dist/

# Copy binaries into package layout
echo "Copying production binaries..."
cp -r dist/servverse-${tag}-darwin-amd64/* "${BIN_DIR}/"

echo "Building raw package..."
pkgbuild --root "${PKG_DIR}" \
         --identifier "${IDENTIFIER}" \
         --version "${VERSION}" \
         --install-location "/" \
         "dist/ServVerse-component.pkg"

echo "Building final distribution package..."
productbuild --package "dist/ServVerse-component.pkg" "dist/ServVerse-macos-setup.pkg"

echo "Package built successfully: dist/ServVerse-macos-setup.pkg"
