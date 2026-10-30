# Project X Boston Recovery

Project X Boston Recovery is a universal Android recovery builder and build companion for the Motorola Moto G Stylus 5G 2024, codename `boston`.

This repository is structured as a reusable GitHub Actions workflow for building custom recovery images across several recovery types, with TWRP as the recommended starting path for the Boston device.

## What this repository includes

- A universal recovery build workflow for GitHub Actions
- A reusable Bash build helper for recovery builds
- Boston-specific default configuration for Motorola Moto G Stylus 5G 2024
- Release automation so successful builds are uploaded and visible before reposting or publishing

## Credits

This project is built on top of the Android open-source and custom-recovery communities and would not be possible without the work of the teams and maintainers behind the sources below.

### Core references

- ProjectXGang
  - Repository owner and project maintainer
- Motorola Moto G Stylus 5G 2024 (`boston`) community
  - Device identification and build target reference
- Team Win Recovery Project (TWRP)
  - Recovery platform and build conventions
- Android Open Source Project (AOSP)
  - Recovery source and build system
- XDA Developers community
  - Device tree and recovery support discussions
- PizzaG / `android_device_motorola_boston`
  - Boston device tree used as the primary TWRP reference
- TNDRP / `android_device_motorola_boston`
  - Secondary Boston device tree and recovery work
- twrpdtgen / `android_device_motorola_boston`
  - Generated TWRP device tree source
- Custom ROM and recovery maintainers across the Android ecosystem
  - Shared knowledge and recovery compatibility work

## Recommended default Boston build settings

- Device codename: `boston`
- Device family: Motorola Moto G Stylus 5G 2024
- Recovery default: `twrp`
- Manifest: `https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git`
- Manifest branch: `twrp-12.1`
- Device tree URL: `https://github.com/PizzaG/android_device_motorola_boston.git`
- Device tree branch: `TWRP`
- Device path: `device/motorola/boston`
- Makefile: `twrp_boston`
- Build target: `recovery`

## How to use

1. Open the GitHub Actions tab.
2. Run the `Universal Recovery Builder` workflow.
3. Fill in the device URL, branch, path, and makefile name.
4. Choose the recovery type and target image.
5. Wait for the build to complete.
6. Download the generated release artifacts from the GitHub release page.

## Release visibility

Successful builds are uploaded to GitHub Releases so they can be reviewed before release distribution.

## Important note

The Boston device tree and recovery makefile must match your actual vendor/kernel source and bootloader partition layout before a successful build can be produced.

---

Project X Boston Recovery
For the Motorola Moto G Stylus 5G 2024 (`boston`) recoveries and custom build community.
