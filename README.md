# Wisp Calendar 🌙

A **beautiful text-based calendar** with stunning visual aesthetics, designed for Arch Linux and Omarchy OS.

```
    ╔══════════════════════════════════════════════════════════════╗
    ║                     November 2025                            ║
    ║──────────────────────────────────────────────────────────────║
    ║  Mon     Tue     Wed     Thu     Fri     Sat     Sun         ║
    ║──────────────────────────────────────────────────────────────║
    ║                                        1       2             ║
    ║   3       4       5       6       7       8       9          ║
    ║  10      11      12      13      14      15      16          ║
    ║  17      18      19      20      21      22      23          ║
    ║  24      25      26      27      28     [29]     30          ║
    ╚══════════════════════════════════════════════════════════════╝
```

## ✨ Features

- 🎨 **Gorgeous cyberpunk aesthetic** with vibrant colors (lavender, purple, pink)
- 📅 **Month view** showing entire month at a glance (one week per row)
- ⌨️  **Intuitive navigation** with arrow keys or vim-style hjkl
- 🎯 **Visual highlights** for today and selected day
- 🌈 **Weekend highlighting** for easy week planning
- 📦 **Lightweight** - pure bash, no heavy dependencies

## AUR Package

This repository contains the AUR package for Wisp Calendar.

## Installation from AUR

```bash
yay -S wisp-calendar
# or
paru -S wisp-calendar
```

## 🎮 Controls

- **Arrow Keys** or **hjkl** - Navigate through days
- **t** - Jump to today
- **q** - Quit

## 🏗️ Building from Source

1. Clone this repository
2. Build with `makepkg -si`
3. Run with `wisp-calendar`

## Development

To build and test the package locally:

```bash
makepkg -si
```

## Project Structure

### PKGBUILD
The main build script for the AUR package. Defines how to build and install wisp-calendar.

### wisp-calendar.install
Install script with post-install and post-remove hooks.

### update-srcinfo.sh
Helper script to generate `.SRCINFO` file from PKGBUILD.

### test-build.sh
Script to test the package build locally.

## Contributing

Contributions are welcome! Feel free to submit issues and pull requests.

## Updating the Package

When updating wisp-calendar:

1. Update `pkgver` in PKGBUILD
2. Update checksums if needed: `makepkg -g`
3. Generate new `.SRCINFO`: `./update-srcinfo.sh`
4. Test the build: `makepkg -si`
5. Commit and push changes

## Testing

### Build and Test Locally

```bash
# Build and install
makepkg -si

# Check installed files
pacman -Ql wisp-calendar

# Run the application
wisp-calendar
```

### Validate Package

```bash
# Check PKGBUILD for issues
namcap PKGBUILD

# Check built package
namcap wisp-calendar-*.pkg.tar.zst
```

## Publishing to AUR

### First Time Setup

```bash
# Generate .SRCINFO
./update-srcinfo.sh

# Clone AUR repository
git clone ssh://aur@aur.archlinux.org/wisp-calendar.git aur-repo
cd aur-repo

# Copy files
cp ../PKGBUILD .
cp ../.SRCINFO .
cp ../wisp-calendar.install .

# Commit and push
git add PKGBUILD .SRCINFO wisp-calendar.install
git commit -m "Initial commit"
git push
```

### Updating on AUR

```bash
# After updating PKGBUILD locally
./update-srcinfo.sh

# In the AUR repo
cd aur-repo
cp ../PKGBUILD ../.SRCINFO ../wisp-calendar.install .
git add PKGBUILD .SRCINFO wisp-calendar.install
git commit -m "Update to version X.Y.Z"
git push
```

## Useful AUR Commands

```bash
# Get package info
yay -Si wisp-calendar

# Search for the package
yay -Ss wisp-calendar

# View PKGBUILD from AUR
yay -Gp wisp-calendar
```

## Resources

- [AUR Submission Guidelines](https://wiki.archlinux.org/title/AUR_submission_guidelines)
- [PKGBUILD Documentation](https://wiki.archlinux.org/title/PKGBUILD)
- [Arch Package Guidelines](https://wiki.archlinux.org/title/Arch_package_guidelines)

## License

MIT License - See LICENSE file for details.
