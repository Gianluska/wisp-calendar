#!/bin/bash
# Helper script to generate .SRCINFO from PKGBUILD
# This file must be committed to the AUR repository along with PKGBUILD

set -e

if [ ! -f "PKGBUILD" ]; then
    echo "Error: PKGBUILD not found in current directory"
    exit 1
fi

echo "Generating .SRCINFO from PKGBUILD..."
makepkg --printsrcinfo > .SRCINFO

if [ -f ".SRCINFO" ]; then
    echo "✓ .SRCINFO generated successfully"
    echo ""
    echo "Files ready for AUR submission:"
    ls -lh PKGBUILD .SRCINFO
    if [ -f "*.install" ]; then
        ls -lh *.install
    fi
else
    echo "Error: Failed to generate .SRCINFO"
    exit 1
fi
