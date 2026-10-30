# Project X Boston Recovery

Project X Boston Recovery is a universal Android recovery builder and build companion for the Motorola Moto G Stylus 5G 2024, codename `boston`.

This repository is built around a reusable GitHub Actions workflow that can target multiple recovery systems using the same device tree and build approach, with a primary focus on TWRP-compatible builds and extendable support for custom recovery types.

## Project purpose

- Build Android recovery images for Motorola Moto G Stylus 5G 2024 (`boston`)
- Provide a reusable workflow for multiple recovery types
- Keep the build process organized and repeatable through GitHub Actions
- Store release artifacts for review before public release

## Credits

Project X Boston Recovery is a collaborative build project based on work from the Android open-source community and custom recovery ecosystem.

### Core contributors and references

- ProjectXGang
  - Repository owner and builder workflow maintainer
- Motorola Moto G Stylus 5G 2024 / `boston` device community
  - Device identification, codename, and build target reference
- Team Win Recovery Project (TWRP)
  - Recovery build framework and device tree conventions
- Android Open Source Project (AOSP)
  - Base recovery build system and source layout
- XDA Developers community
  - Unofficial kernel, device tree, and TWRP discussion support
- PizzaG / `android_device_motorola_boston`
  - Device tree source used as the primary Boston reference
- TNDRP / `android_device_motorola_boston`
  - Secondary Boston device tree and recovery experimentation source
- twrpdtgen / `android_device_motorola_boston`
  - Generated TWRP device tree for standard build compatibility
- Custom ROM and recovery maintainers across the Android community
  - Shared build knowledge, tooling, and recovery support

## Repository usage

This repository contains:

- GitHub Actions workflows for recovery building
- A universal builder script for multiple recovery types
- Boston-specific build guidance and notes
- Release artifacts generated after workflow success

## Recommended Boston defaults

- Device codename: `boston`
- Device family: Motorola Moto G Stylus 5G 2024
- Recovery default: TWRP
- Manifest: `https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git`
- Manifest branch: `twrp-12.1`
- Device tree: `https://github.com/PizzaG/android_device_motorola_boston.git`
- Device tree branch: `TWRP`
- Device path: `device/motorola/boston`
- Makefile: `twrp_boston`
- Build target: `recovery`

## Notes

This repository is designed as a reusable universal builder template; the Boston-specific defaults are intended as a starting point and may need tuning for your exact vendor tree, kernel, and partition layout.

## License

This project is provided for educational and build-development purposes. Please respect the licenses of all upstream Android, vendor, and recovery sources used in your builds.

## Important build reminder

Use only device trees, kernels, and vendor sources that you are authorized to build and distribute.

---

Project X Boston Recovery
Built for the Motorola Moto G Stylus 5G 2024 (`boston`) recovery community.
