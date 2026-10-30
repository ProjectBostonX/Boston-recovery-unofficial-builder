#!/usr/bin/env bash
set -euo pipefail

RECOVERY_TYPE="${RECOVERY_TYPE:-twrp}"
MANIFEST_URL="${MANIFEST_URL:-https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git}"
MANIFEST_BRANCH="${MANIFEST_BRANCH:-twrp-12.1}"
DEVICE_TREE_URL="${DEVICE_TREE_URL:-https://github.com/PizzaG/android_device_motorola_boston.git}"
DEVICE_TREE_BRANCH="${DEVICE_TREE_BRANCH:-TWRP}"
DEVICE_PATH="${DEVICE_PATH:-device/motorola/boston}"
COMMON_TREE_URL="${COMMON_TREE_URL:-}"
COMMON_PATH="${COMMON_PATH:-}"
DEVICE_NAME="${DEVICE_NAME:-boston}"
MAKEFILE_NAME="${MAKEFILE_NAME:-twrp_boston}"
BUILD_TARGET="${BUILD_TARGET:-recovery}"
DEVICE_CODENAME="${DEVICE_CODENAME:-boston}"
EXTRA_DEPS_URL="${EXTRA_DEPS_URL:-}"
EXTRA_DEPS_PATH="${EXTRA_DEPS_PATH:-}"

if [[ -z "$DEVICE_TREE_URL" || -z "$DEVICE_PATH" ]]; then
  echo "DEVICE_TREE_URL and DEVICE_PATH are required."
  exit 1
fi

if [[ -d .repo ]]; then
  SRC_ROOT="$PWD"
elif [[ -d workspace && -d workspace/.repo ]]; then
  SRC_ROOT="$PWD/workspace"
else
  SRC_ROOT="$PWD"
fi

if [[ ! -d "$SRC_ROOT/.repo" ]]; then
  mkdir -p workspace
  cd workspace
  repo init --depth=1 -u "$MANIFEST_URL" -b "$MANIFEST_BRANCH"
  SRC_ROOT="$PWD"
else
  cd "$SRC_ROOT"
fi

if [[ ! -d "$DEVICE_PATH" ]]; then
  git clone "$DEVICE_TREE_URL" -b "$DEVICE_TREE_BRANCH" "$DEVICE_PATH"
fi

if [[ -n "$COMMON_TREE_URL" && -n "$COMMON_PATH" ]]; then
  if [[ ! -d "$COMMON_PATH" ]]; then
    git clone "$COMMON_TREE_URL" -b "$DEVICE_TREE_BRANCH" "$COMMON_PATH"
  fi
fi

if [[ -n "$EXTRA_DEPS_URL" && -n "$EXTRA_DEPS_PATH" ]]; then
  if [[ ! -d "$EXTRA_DEPS_PATH" ]]; then
    git clone "$EXTRA_DEPS_URL" "$EXTRA_DEPS_PATH"
  fi
fi

for depfile in \
  "$DEVICE_PATH/${RECOVERY_TYPE}.dependencies" \
  "$DEVICE_PATH/${DEVICE_CODENAME}.dependencies" \
  "$DEVICE_PATH/dependencies.txt"; do
  if [[ -f "$depfile" ]]; then
    bash "${GITHUB_WORKSPACE}/scripts/convert.sh" "$depfile" || true
    break
  fi
done

repo sync -j"$(nproc --all)" --force-sync || repo sync -j"$(nproc --all)" || true

source build/envsetup.sh || true
export ALLOW_MISSING_DEPENDENCIES=true

for target in \
  "${MAKEFILE_NAME}-eng" \
  "${MAKEFILE_NAME}-userdebug" \
  "${MAKEFILE_NAME}"; do
  if lunch "$target" >/dev/null 2>&1; then
    LUNCH_TARGET="$target"
    break
  fi
done

if [[ -z "${LUNCH_TARGET:-}" ]]; then
  echo "Unable to resolve a valid lunch target for ${MAKEFILE_NAME}."
  echo "Please confirm the makefile name and device tree compatibility."
  exit 1
fi

make clean >/dev/null 2>&1 || true
make "${BUILD_TARGET}image" -j"$(nproc --all)"

ARTIFACT_DIR="out/target/product/${DEVICE_NAME}"
if [[ -d "$ARTIFACT_DIR" ]]; then
  echo "Recovery build output directory: $ARTIFACT_DIR"
  ls -1 "$ARTIFACT_DIR" | head -n 50 || true
else
  echo "No artifact directory found at $ARTIFACT_DIR"
  exit 1
fi
