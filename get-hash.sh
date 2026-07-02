#!/usr/bin/env bash

set -e

VERSION=""
ARCHS=()

usage() {
  echo "Usage: $0 --version <version> [--x86] [--aarch64]"
  echo "Example: $0 --version 6.0.9.01 --x86 --aarch64"
  echo "         $0 --version 6.0.9.01 --x86"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --version)
      VERSION="$2"
      shift 2
      ;;
    --x86)
      ARCHS+=("x64")
      shift
      ;;
    --aarch64)
      ARCHS+=("aarch64")
      shift
      ;;
    *)
      echo "Unknown flag: $1"
      usage
      ;;
  esac
done

if [ -z "$VERSION" ]; then
  echo "Error: --version is required"
  usage
fi

if [ ${#ARCHS[@]} -eq 0 ]; then
  echo "Error: at least one of --x86 or --aarch64 is required"
  usage
fi

for ARCH in "${ARCHS[@]}"; do
  URL="https://github.com/astroimagej/astroimagej/releases/download/${VERSION}/AstroImageJ-${VERSION}-linux-${ARCH}.tgz"
  echo -n "${ARCH}: "
  SRI=$(nix-prefetch-url --type sha256 "$URL")
  echo "$(nix hash to-sri --type sha256 $SRI)"
done
