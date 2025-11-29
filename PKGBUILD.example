# Maintainer: Your Name <your.email@example.com>
# This is a functional example to test the boilerplate

pkgname=hello-aur-test
pkgver=1.0.0
pkgrel=1
pkgdesc="A simple test package to validate the PKGBUILD"
arch=('any')
url="https://github.com/test/hello-aur-test"
license=('MIT')
depends=('bash')
makedepends=()
source=()
sha256sums=()

# Prepare the environment (create the script during build)
prepare() {
    # Create a temporary directory for our files
    mkdir -p "${srcdir}/${pkgname}-${pkgver}"
    cd "${srcdir}/${pkgname}-${pkgver}"

    # Create a simple script
    cat > hello-aur << 'EOF'
#!/bin/bash
echo "========================================="
echo "  Hello! This is an AUR test package!"
echo "  Version: 1.0.0"
echo "========================================="
echo ""
echo "System information:"
echo "  User: $(whoami)"
echo "  Date: $(date)"
echo "  Hostname: $(hostname)"
echo ""
echo "This package was built successfully!"
EOF

    # Create a license file
    cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2025 Test Package

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction.
EOF

    # Create a README
    cat > README.md << 'EOF'
# Hello AUR Test

This is a simple test package created to validate the AUR boilerplate.

## Usage

Run the command:

```bash
hello-aur
```

## Built with

- Bash
- Arch Linux PKGBUILD
EOF
}

# No build needed for simple bash scripts
build() {
    cd "${srcdir}/${pkgname}-${pkgver}"
    # Nothing to compile
}

# Install the files
package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    # Install the executable
    install -Dm755 hello-aur "${pkgdir}/usr/bin/hello-aur"

    # Install documentation
    install -Dm644 README.md "${pkgdir}/usr/share/doc/${pkgname}/README.md"

    # Install license
    install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
}

# vim:set ts=4 sw=4 et:
