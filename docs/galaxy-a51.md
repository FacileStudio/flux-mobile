# Flux Mobile preview on the Galaxy A51

This preview gives a Galaxy A51 an Android 16 system without Google, with the Flux home screen
and the Facile apps. It does not use a Flux build yet: the system underneath is crDroid, a
community ROM built on LineageOS. A real Flux Mobile image replaces it later.

## Before you start

- **Model.** This works only on the global Galaxy A51 4G, model `SM-A515F` (codename `a51`). US
  models (`A515U`, `A515U1`) cannot unlock their bootloader.
- **Everything on the phone is erased.** Back up first, and remove every Google account from the
  phone so Factory Reset Protection does not lock you out.
- **Knox is tripped for good.** Unlocking burns a one-time fuse on Samsung phones, and Samsung's
  Knox services stop working, even if you go back to Samsung's system.
- **Some apps will not run.** Banking and payment apps that check Google Play Integrity usually
  refuse a phone without Google's certified system.
- **No more system updates are promised.** crDroid's A51 page marks this build as no longer
  supported (https://crdroid.net/a51/12). It gets no security fixes after 12.11.

You need a Linux computer with `adb` and `heimdall` (Debian and Ubuntu:
`sudo apt install adb heimdall-flash`), a USB-C data cable, and a battery above 50%.

## 1. Unlock the bootloader

1. Settings > About phone > Software information, tap **Build number** seven times.
2. Settings > Developer options, turn on **OEM unlocking**.
3. Turn the phone off. Hold **Volume Down + Volume Up** and plug in the USB cable.
4. On the warning screen, hold **Volume Up** until it asks "Unlock bootloader?", then press
   **Volume Up** again. The phone wipes itself and restarts.
5. Go through setup without a Google account, turn on Developer options again and check that
   **OEM unlocking** is still on.

crDroid needs Samsung's U5 bootloader or newer. Check the build number in Settings > About phone >
Software information: in `A515FXXU5EUJ4`, the `U5` is the bootloader version. Update the phone
through Samsung's own updater first if it shows a lower number.

## 2. Flash the crDroid recovery

1. Download crDroid 12.11 for `a51` from https://crdroid.net/a51/12 and unzip it. Keep the
   `.zip`, and take `recovery.img` and `vbmeta.img` out of it.
2. Turn the phone off, hold **Volume Down + Volume Up**, plug in the cable, and press
   **Volume Up** to enter Download mode.
3. Flash:

   ```sh
   heimdall flash --VBMETA vbmeta.img --RECOVERY recovery.img
   ```

4. As the phone restarts, hold **Volume Up + Power** with the cable still plugged in, to boot
   into the new recovery.

## 3. Install the system, without Google

1. In the recovery: **Factory reset** > **Format data/factory reset** > **Format data**.
2. **Apply update** > **Apply from ADB**, then on the computer:

   ```sh
   adb sideload crDroidAndroid-16.0-20260822-a51-v12.11.zip
   ```

3. Do not install the GApps package. Skipping it is what keeps Google off the phone.
4. Reboot and finish setup.

## 4. Install Flux and the Facile apps

1. Download the Flux home screen:
   https://github.com/FacileStudio/flux-launcher/releases/latest/download/flux-launcher.apk
   and open it. Allow installs from the browser when Android asks.
2. Press **Home** and choose **Flux** (and **Always** if Android asks). You can change it later in
   Settings > Apps > Default apps > Home app.
3. Install the Facile apps that have an Android version from their download pages:
   - Bulle: https://bulle.facile.studio/downloads
   - Courrier: https://courrier.facile.studio/downloads
   - Sablier: https://sablier.facile.studio/downloads

   They show up in the **Facile** group at the top of the Flux home screen.
4. For other apps, install F-Droid from https://f-droid.org.

To check that the Flux APK is ours, its signing certificate SHA-256 is
`F4:7F:EF:33:ED:46:8A:DB:1A:51:E8:36:77:F2:A9:12:79:7D:BB:CB:94:64:86:AB:79:DE:5D:F1:4E:77:F1:08`
(`apksigner verify --print-certs flux-launcher.apk`).

## Going back to Samsung's system

Flash the stock firmware for your exact model and region with Heimdall or Odin. Knox stays
tripped.

## Sources

- crDroid A51 download and install: https://crdroid.net/a51/12 and https://crdroid.net/a51/12/install
- Knox warranty fuse: https://docs.samsungknox.com/admin/knox-platform-for-enterprise/faq
- Play Integrity and custom ROMs: https://www.androidauthority.com/google-play-integrity-hardware-attestation-3561592
