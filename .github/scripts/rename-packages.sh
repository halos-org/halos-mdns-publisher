#!/bin/bash
# Rename .deb packages with distro+component suffix
# This script handles the transitional package (arch: all)

set -e

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --version) VERSION="$2"; shift 2 ;;
        --distro) DISTRO="$2"; shift 2 ;;
        --component) COMPONENT="$2"; shift 2 ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

PACKAGE_NAME="${PACKAGE_NAME:-halos-mdns-publisher}"

# Find the .deb file - arch: all for transitional package
OLD_NAME="${PACKAGE_NAME}_${VERSION}_all.deb"
NEW_NAME="${PACKAGE_NAME}_${VERSION}_all+${DISTRO}+${COMPONENT}.deb"

if [ -f "$OLD_NAME" ]; then
    echo "Renaming package: $OLD_NAME -> $NEW_NAME"
    mv "$OLD_NAME" "$NEW_NAME"
    echo "Package renamed successfully"
else
    echo "Error: Expected package not found: $OLD_NAME"
    echo "Available .deb files:"
    ls -la *.deb 2>/dev/null || echo "None found"
    exit 1
fi
