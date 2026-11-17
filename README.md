# Flux Mobile

Flux for your phone: a private Android system without Google, with the Facile apps preinstalled.
It is built on LineageOS and microG.

This repo is not a fork. It is a small overlay that the LineageOS build picks up on its own:

- `manifests/flux.xml` is a repo local manifest. It checks this repo out as `vendor/flux`, links
  `product.mk` to `vendor/extra/product.mk` (LineageOS's `config/common.mk` inherits that file
  first), and adds microG from
  [lineageos4microg/android_vendor_partner_gms](https://github.com/lineageos4microg/android_vendor_partner_gms).
- `product.mk` adds the Flux launcher and points the LineageOS updater at Facile's update server.
- `prebuilt/FluxLauncher` wraps the signed APK from
  [flux-launcher](https://github.com/FacileStudio/flux-launcher) releases.

LineageOS itself stays untouched, so an update is `repo sync` with nothing to merge.

## Build

You need a Linux machine with 64 GB of RAM and 400 GB of free disk, and the
[LineageOS build packages](https://wiki.lineageos.org/emulator). Never build on ruche: its disk is
shared with production databases.

From an empty directory:

```sh
sh /path/to/flux-mobile/scripts/build.sh <device> [lineage-branch]
```

The script runs `repo init` on LineageOS (default `lineage-23.2`), adds `manifests/flux.xml`,
syncs, downloads the launcher APK, and builds with `WITH_GMS=true` so microG is included. The
flashable zip lands in `out/target/product/<device>/`.

## Devices

| Tier | Meaning | Devices |
|---|---|---|
| Official | Built and tested every month | none yet |
| Community | Built from community device trees, no promise | Galaxy A51 (planned) |
| Legacy | No longer updated | none |

## Not done yet

- Branding: boot animation, wallpaper, setup wizard, and the name shown in About phone.
- Flux as the default home screen. Replacing `Launcher3QuickStep` also removes the recents screen
  that ships inside it, so this needs care.
- Release keys. Test builds are signed with the public test keys until the keys exist
  (https://wiki.lineageos.org/signing_builds).
- The update server behind `flux.facile.studio/mobile/api/v2/devices/{device}/builds`. It must
  answer the JSON described in https://github.com/LineageOS/android_packages_apps_Updater.
- Registre sign-in in the setup wizard.

## License

GPL-3.0, like Flux. LineageOS, AOSP and microG keep their own licenses.
