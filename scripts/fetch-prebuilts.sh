#!/bin/sh
set -eu

root=$(cd "$(dirname "$0")/.." && pwd)
tag=${FLUX_LAUNCHER_TAG:-latest}

if [ "$tag" = latest ]; then
	url=https://github.com/FacileStudio/flux-launcher/releases/latest/download/flux-launcher.apk
else
	url=https://github.com/FacileStudio/flux-launcher/releases/download/$tag/flux-launcher.apk
fi

curl -fsSL "$url" -o "$root/prebuilt/FluxLauncher/FluxLauncher.apk"
curl -fsSL "$url.sha256" | awk '{print $1 "  '"$root"'/prebuilt/FluxLauncher/FluxLauncher.apk"}' | sha256sum -c -
