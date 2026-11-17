#!/bin/sh
set -eu

usage() {
	echo "usage: $0 <device> [lineage-branch]" >&2
	echo "run from an empty directory with 64 GB of RAM and 400 GB of free disk" >&2
	exit 2
}

[ $# -ge 1 ] || usage
device=$1
branch=${2:-lineage-23.2}
here=$(cd "$(dirname "$0")/.." && pwd)

repo init -u https://github.com/LineageOS/android.git -b "$branch" --git-lfs --no-clone-bundle
mkdir -p .repo/local_manifests
cp "$here/manifests/flux.xml" .repo/local_manifests/flux.xml
repo sync -c -j"$(nproc)" --no-tags
sh vendor/flux/scripts/fetch-prebuilts.sh

export WITH_GMS=true
. build/envsetup.sh
breakfast "$device"
m bacon
