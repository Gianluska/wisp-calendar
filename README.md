# AUR Package Boilerplate

A complete boilerplate for creating Arch User Repository (AUR) packages.

## Quick Start

1. Clone or copy this boilerplate
2. Customize the `PKGBUILD` file with your package details
3. Optionally customize the `.install` script
4. Generate `.SRCINFO` file
5. Test locally
6. Submit to AUR

## Files Included

### PKGBUILD
The main build script that defines how to build and install your package. This file includes:
- Comprehensive metadata fields (name, version, description, etc.)
- Examples for common build systems (Make, CMake, Meson, Python, Rust, Go, Node.js)
- Well-commented sections for easy customization

### package-name.install
Optional install script for pre/post install/upgrade/remove hooks. Useful for:
- Updating system caches
- Enabling systemd services
- Setting permissions
- Displaying important messages to users

### .gitignore
Ignores common build artifacts and temporary files:
- Downloaded source archives
- Extracted source directories
- Built packages
- makepkg temporary files

### update-srcinfo.sh
Helper script to generate `.SRCINFO` file from PKGBUILD

## Customization Guide

### 1. Update PKGBUILD Metadata

```bash
pkgname=your-package-name       # Package name (lowercase, no spaces)
pkgver=1.0.0                    # Version number
pkgrel=1                        # Package release number (increment for PKGBUILD changes)
pkgdesc="Description here"      # Short description
arch=('x86_64')                 # Supported architectures
url="https://..."               # Project URL
license=('MIT')                 # License(s)
```

### 2. Configure Dependencies

```bash
depends=('dep1' 'dep2')         # Runtime dependencies
makedepends=('build-tool')      # Build-time dependencies
optdepends=(                    # Optional dependencies
    'tool: for feature X'
)
```

### 3. Set Up Sources

```bash
source=("${pkgname}-${pkgver}.tar.gz::https://...")
sha256sums=('SKIP')  # Generate with: makepkg -g
```

To generate checksums:
```bash
makepkg -g
```

### 4. Choose Build Function

Uncomment and customize the appropriate build function for your project type:
- **Make/Autotools**: Standard `./configure && make`
- **CMake**: Modern C/C++ projects
- **Meson**: Fast build system
- **Python**: Use `python -m build`
- **Rust**: Use `cargo build`
- **Go**: Go applications
- **Node.js**: npm packages

### 5. Implement Package Function

The `package()` function installs files into `${pkgdir}`:

```bash
package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    # Install binary
    install -Dm755 "${pkgname}" "${pkgdir}/usr/bin/${pkgname}"

    # Install license
    install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"

    # Install documentation
    install -Dm644 README.md "${pkgdir}/usr/share/doc/${pkgname}/README.md"

    # Install man page
    install -Dm644 "${pkgname}.1" "${pkgdir}/usr/share/man/man1/${pkgname}.1"
}
```

### 6. Customize .install Script (Optional)

If you need post-install hooks:

1. Rename `package-name.install` to `${pkgname}.install`
2. Uncomment relevant sections in the script
3. Ensure PKGBUILD references it: `install="${pkgname}.install"`

## Testing Your Package

### Build Locally

```bash
# Build the package
makepkg

# Build and install
makepkg -si

# Clean build (removes existing src/ and pkg/ directories)
makepkg -C

# Force rebuild
makepkg -f
```

### Test Installation

```bash
# Install built package
sudo pacman -U your-package-name-1.0.0-1-x86_64.pkg.tar.zst

# Check installed files
pacman -Ql your-package-name

# Remove package
sudo pacman -R your-package-name
```

### Validate PKGBUILD

```bash
# Check for common issues
namcap PKGBUILD

# Check built package
namcap your-package-name-1.0.0-1-x86_64.pkg.tar.zst
```

## Publishing to AUR

### 1. Generate .SRCINFO

```bash
# Use the helper script
./update-srcinfo.sh

# Or manually
makepkg --printsrcinfo > .SRCINFO
```

### 2. Set Up AUR Repository

```bash
# Clone AUR repository (first time)
git clone ssh://aur@aur.archlinux.org/your-package-name.git aur-repo
cd aur-repo

# Copy files
cp ../PKGBUILD .
cp ../.SRCINFO .
# Copy .install if you have one
```

### 3. Commit and Push

```bash
# Add files
git add PKGBUILD .SRCINFO

# Commit
git commit -m "Initial commit: version 1.0.0"

# Push to AUR
git push
```

### 4. Update Package

When updating the package:

```bash
# Update pkgver in PKGBUILD
# Reset pkgrel to 1
# Update checksums: makepkg -g

# Generate new .SRCINFO
makepkg --printsrcinfo > .SRCINFO

# Commit and push
git add PKGBUILD .SRCINFO
git commit -m "Update to version X.Y.Z"
git push
```

## Common PKGBUILD Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `pkgname` | Package name | `mypackage` |
| `pkgver` | Version number | `1.0.0` |
| `pkgrel` | Release number | `1` |
| `epoch` | Force version ordering | `1` |
| `pkgdesc` | Short description | `"A useful tool"` |
| `arch` | Architectures | `('x86_64' 'i686')` |
| `url` | Project homepage | `https://example.com` |
| `license` | License(s) | `('GPL' 'MIT')` |
| `depends` | Runtime dependencies | `('glibc' 'openssl')` |
| `makedepends` | Build dependencies | `('cmake' 'gcc')` |
| `checkdepends` | Test dependencies | `('pytest')` |
| `optdepends` | Optional features | `('tool: for X')` |
| `provides` | Virtual packages | `('editor')` |
| `conflicts` | Conflicting packages | `('other-package')` |
| `replaces` | Replaced packages | `('old-package')` |
| `backup` | Config files to backup | `('etc/mypackage.conf')` |
| `options` | Build options | `('!strip' 'docs')` |
| `install` | Install script | `${pkgname}.install` |
| `source` | Source URLs/files | `("url" "file")` |
| `sha256sums` | Checksums | `('abc123...')` |

## Build Options

Common options for the `options` array:

- `strip` / `!strip` - Strip binaries/libraries
- `docs` / `!docs` - Include documentation
- `libtool` / `!libtool` - Keep libtool files
- `staticlibs` / `!staticlibs` - Build static libraries
- `emptydirs` / `!emptydirs` - Keep empty directories
- `zipman` / `!zipman` - Compress man pages
- `ccache` / `!ccache` - Use ccache
- `debug` / `!debug` - Build with debug symbols

## Helpful Commands

```bash
# Get package info from AUR
yay -Si package-name

# Search AUR
yay -Ss search-term

# Update all AUR packages
yay -Sua

# Build in clean chroot (recommended for final testing)
extra-x86_64-build

# View PKGBUILD from AUR
yay -Gp package-name
```

## Resources

- [AUR Submission Guidelines](https://wiki.archlinux.org/title/AUR_submission_guidelines)
- [PKGBUILD Documentation](https://wiki.archlinux.org/title/PKGBUILD)
- [Arch Package Guidelines](https://wiki.archlinux.org/title/Arch_package_guidelines)
- [makepkg Manual](https://man.archlinux.org/man/makepkg.8)
- [namcap Tool](https://wiki.archlinux.org/title/Namcap)

## License

This boilerplate is released into the public domain. Use it however you like.
