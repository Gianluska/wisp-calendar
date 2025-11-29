# Testing Guide - AUR Packages

This guide explains how to test if your AUR package is building correctly.

## Method 1: Quick Test with Automated Script

Use the `test-build.sh` script for a complete automated test:

```bash
./test-build.sh
```

This script will:
1. ✓ Validate PKGBUILD with namcap
2. ✓ Build the package
3. ✓ Validate the built package
4. ✓ Show package contents
5. ✓ Offer installation option

## Method 2: Test with Example Package

If you just want to test the boilerplate:

```bash
# Copy the example to PKGBUILD
cp PKGBUILD.example PKGBUILD

# Run the test script
./test-build.sh
```

## Method 3: Manual Step-by-Step Testing

### 1. Validate PKGBUILD Syntax

```bash
# Install namcap (if you don't have it yet)
sudo pacman -S namcap

# Validate PKGBUILD
namcap PKGBUILD
```

### 2. Build the Package

```bash
# Basic build
makepkg

# Build with prior cleanup
makepkg -C

# Build and install
makepkg -si

# Forced build (rebuild)
makepkg -f

# Build without re-extracting
makepkg -e
```

### 3. Verify Checksums

```bash
# Generate checksums automatically
makepkg -g

# Update checksums in PKGBUILD
# Copy the output from the command above and paste into PKGBUILD
```

### 4. Validate Built Package

```bash
# Validate with namcap
namcap *.pkg.tar.zst

# View package contents
tar -tf *.pkg.tar.zst

# Extract to inspect
tar -xf *.pkg.tar.zst -C /tmp/pkg-inspect
tree /tmp/pkg-inspect
```

### 5. Test Installation

```bash
# Install
sudo pacman -U *.pkg.tar.zst

# Verify installed files
pacman -Ql package-name

# Verify information
pacman -Qi package-name

# Remove
sudo pacman -R package-name
```

## Useful Commands During Development

### Clean Previous Builds

```bash
# Remove src/, pkg/ and built packages
rm -rf src/ pkg/ *.pkg.tar.zst

# Or use makepkg
makepkg -c  # clean after build
```

### Build Debugging

```bash
# See only warnings/errors
makepkg 2>&1 | grep -i "error\|warning"

# Verbose build
makepkg --noconfirm --needed

# Keep src/ directory for debugging
makepkg -f --noprepare
```

### Test Only Specific Parts

```bash
# Only download sources
makepkg -o

# Only extract
makepkg -e

# Only build (no package)
makepkg -f --nobuild
```

## Validation Checklist

Before publishing to AUR, verify:

- [ ] PKGBUILD passes namcap without critical errors
- [ ] Package builds without errors: `makepkg -f`
- [ ] Checksums are correct (don't use 'SKIP' in production)
- [ ] Package installs correctly: `makepkg -si`
- [ ] Files are in the correct locations: `pacman -Ql`
- [ ] Binaries work after installation
- [ ] .SRCINFO is up to date: `makepkg --printsrcinfo > .SRCINFO`
- [ ] Dependencies are correct (test on clean system if possible)
- [ ] .install script works (if applicable)
- [ ] Package removes correctly: `sudo pacman -R`

## Common Issues

### "ERROR: Cannot find the strip binary"
```bash
# Install base-devel
sudo pacman -S base-devel
```

### "ERROR: Cannot find the fakeroot binary"
```bash
# Install fakeroot
sudo pacman -S fakeroot
```

### "One or more PGP signatures could not be verified"
```bash
# Import GPG key
gpg --recv-keys KEYID

# Or disable verification (not recommended)
# Add to PKGBUILD: validpgpkeys=()
```

### "ERROR: Integrity checks (sha256) differ"
```bash
# Regenerate checksums
makepkg -g

# Copy the output and update sha256sums in PKGBUILD
```

### Build fails but doesn't show clear error
```bash
# Inspect manually
cd src/package-name-version/
# Try build commands manually
```

## Testing in Clean Environment (Advanced)

To ensure all dependencies are correct:

```bash
# Install devtools
sudo pacman -S devtools

# Build in clean chroot
extra-x86_64-build
```

This builds the package in an isolated environment, ensuring there are no undeclared dependencies.

## Next Steps

After everything works:

1. Generate .SRCINFO: `./update-srcinfo.sh`
2. Commit to git: `git add PKGBUILD .SRCINFO && git commit -m "Initial commit"`
3. Push to AUR: `git push`

## Additional Tools

- **aurpublish**: Facilitates AUR publishing
- **pkgctl**: Official Arch tool for package maintenance
- **repoctl**: Manage local repositories
- **aurutils**: Set of AUR tools

```bash
# Install useful tools
yay -S aurpublish aurutils
```
