# Setting up on a new machine

Everything here was learned the hard way on a Windows 11 / 8GB machine. Skipping
a step generally means a build that fails ten minutes in.

---

## 1. Clone

```bash
gh repo clone lakshaymehra-pixel/Salaryuncle_app
cd Salaryuncle_app
```

Or with plain git:

```bash
git clone https://github.com/lakshaymehra-pixel/Salaryuncle_app.git
cd Salaryuncle_app
```

## 2. Prerequisites

| Tool | Version | Note |
|------|---------|------|
| Flutter | `>=3.3.0 <4.0.0` (Dart SDK) | `flutter doctor` should be clean for Android |
| JDK | **21** | 17 and 25 both fail against this Gradle/AGP pair |
| Android SDK | API 36 installed | `targetSdk 36`, `minSdk 23` |

Point Flutter at JDK 21 explicitly — Flutter otherwise picks whatever `java` is
on PATH, and a JDK 25 default breaks the Kotlin compile:

```bash
# Windows (Android Studio's bundled JDK)
flutter config --jdk-dir="C:\Program Files\Android\openjdk\jdk-21.0.8"

# macOS / Linux
flutter config --jdk-dir="$(/usr/libexec/java_home -v 21)"
```

## 3. Dependencies

```bash
flutter pub get
```

## 4. Patch two cached packages (required — the build fails without this)

Two plugins predate the current Kotlin compiler's null-safety checks and will
not compile. They live in the **pub cache**, not in this repo, so every new
machine needs this, and so does any `flutter pub cache repair`.

Run from the repo root:

```bash
# resolve the cache location
PUB="${PUB_CACHE:-$HOME/AppData/Local/Pub/Cache}"   # Windows
# PUB="${PUB_CACHE:-$HOME/.pub-cache}"              # macOS / Linux

sed -i 's/bitmap.compress(compressFormat, compressQuality, os)/bitmap.compress(compressFormat, compressQuality, os!!)/' \
  "$PUB/hosted/pub.dev/hl_image_picker_android-1.2.11/android/src/main/kotlin/com/howl/hl_image_picker/ImageFileCompressEngine.kt"

sed -i -e 's/).signingInfo.apkContentsSigners/).signingInfo!!.apkContentsSigners/' \
       -e 's/PackageManager.GET_SIGNATURES).signatures$/PackageManager.GET_SIGNATURES).signatures!!/' \
  "$PUB/hosted/pub.dev/smart_auth-2.0.0/android/src/main/kotlin/fman/ge/smart_auth/AppSignatueHelper.kt"
```

If the version numbers in those paths have moved on, find them with:
```bash
ls "$PUB/hosted/pub.dev" | grep -E 'hl_image_picker_android|smart_auth'
```

> `smart_auth`'s patch asserts `signingInfo` is non-null. It is nullable on API
> 28+, and the surrounding `try` only catches `NameNotFoundException`, so a null
> would surface as an unhandled NPE. The method is only reached via the
> `getAppSignature` channel call, which this app never makes — but if you start
> using it, guard properly instead of asserting.

## 5. Release signing

The keystore is **not** in this repo. Without it, `--release` silently falls back
to the debug key (see `android/app/build.gradle`), producing an APK that installs
for testing but **cannot update the Play Store listing**.

Get `key.properties` and the `.jks` from whoever holds them, then:

```
android/key.properties      <- storeFile / storePassword / keyAlias / keyPassword
android/<name>.jks          <- the keystore itself
```

Both are git-ignored. Never commit them.

## 6. Build

```bash
flutter run                  # debug, on a connected device
flutter build apk --release  # output: build/app/outputs/flutter-apk/app-release.apk
```

---

## Memory limits (8GB machines)

`android/gradle.properties` is tuned down for a small machine:
`org.gradle.jvmargs=-Xmx2G`, `org.gradle.workers.max=2`, `kotlin.daemon.jvmargs=-Xmx1G`.

On such a machine:

- **Never run a build and the Android emulator at once.** The JVM dies with
  *"Gradle build daemon disappeared unexpectedly"*. The emulator alone is barely
  usable — System UI ANRs constantly. Use a real device over USB instead.
- Two concurrent builds will also kill each other. Let one finish.
- If a build dies oddly, clear stale daemons first: `taskkill /F /IM java.exe`
  (Windows) or `pkill -f GradleDaemon`.

On a 16GB+ machine you can raise `-Xmx` to 4G and drop `workers.max`.

## Testing on a real device

```bash
adb devices                                                   # confirm it is listed
adb install -r build/app/outputs/flutter-apk/app-release.apk
adb logcat -v raw flutter:I '*:S'                             # app logs only
```

On Git Bash, prefix adb commands that take device paths with
`MSYS_NO_PATHCONV=1`, or `/sdcard/...` gets rewritten into a Windows path and
the command fails confusingly.

## Before you change UI code

Read the two trap sections in [README.md](README.md). In short: `responsive_sizer`'s
`.sp` is **quadratic** (`110.sp` is ~774px, not 110px), and wrapping a
`LayoutBuilder` in `Obx` renders a **blank white screen** in release. Both cost a
day each to find.
