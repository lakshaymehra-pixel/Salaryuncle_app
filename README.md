# SalaryUncle — Instant Salary Loan App

A Flutter loan application with a deep-green + gold fintech UI. Users apply for
short-term salary advances, track active loans, repay, and manage their profile,
backed by a live loan-origination API.

> **Tagline:** *Salary khatam? Tension nahi! Instant loan, seedha bank account mein.*

---

## ✨ Features

- **Phone + OTP login** with automatic OTP read (SMS User Consent API).
- **Deep-green & gold dashboard** — active-loan hero card, total repayment,
  eligibility strip, quick actions, and tips.
- **Loan application flow** — PAN / Aadhaar KYC, personal, employment, income,
  residence and bank details, document upload.
- **Loan calculator** — pick amount & tenure, live Key-Fact-Statement (KFS)
  breakdown (processing fee, GST, interest, total repayment).
- **My Loans / Payments / Profile** tabs with a floating glass bottom dock and a
  gold "New Loan" FAB.
- **Repayment** through an in-app WebView.
- Firebase push notifications, Meta events, in-app review.

## 🧭 The apply journey

The journey is **server-driven and resumable**. Every API response carries a
`step_stage`; [`lib/utils/events.dart`](lib/utils/events.dart) maps that stage to
a route, so a user who closes the app mid-application resumes at the step they
left. `Events.getCurrentEvent()` turns the same stage into a 0–13 index for the
progress stepper.

```
Splash → Login → OTP → Occupation → PAN → Personal → Residence → Income
  → Aadhaar OKYC → Employment → Loan amount → Quote → Documents → Bank
  → Thank you → Dashboard
```

Dashboard controllers push the user back to the first incomplete step, so the
stage string from the backend is the single source of truth for where someone is.

## 🎨 Design system

Central tokens live in [`lib/utils/color_constants.dart`](lib/utils/color_constants.dart):

| Token | Value | Use |
|-------|-------|-----|
| `greenDeep` | `#0B3D2E` | primary dark background, dock |
| `green2` | `#14523E` | gradients |
| `gold` / `goldText` | `#D4A017` / `#F3CE6B` | CTAs, accents |
| `greenSoft` | `#E8F3EE` | tinted surfaces |

Gradients: `loanCardGradient` (green), `goldGradient` (gold CTA), `brandGradient`.

## 🏗️ Tech stack

- **Flutter** (Dart) — `sdk >=3.3.0 <4.0.0`
- **GetX** — state management, routing, DI (bindings / controllers / views)
- **Dio** — REST API client
- **Firebase** — Core + Messaging
- **pinput + smart_auth** — OTP entry & auto-read
- **responsive_sizer** — adaptive sizing (read the warning below before using it)

## 📁 Project structure

```
lib/
├── binding/          # GetX bindings (DI per screen)
├── controller/       # Business logic controllers
├── custom_widgets/   # Reusable UI (hero cards, dock, form cards, inputs…)
├── models/           # API request/response models
├── routes/           # Named routes + page routes
├── services/         # api_service.dart, api_constants.dart
├── utils/            # color_constants, events, shared_constants, helpers
└── views/            # Screens (login, otp, home/dashboard, loan, kyc, repay, profile…)
```

---

## ⚠️ Two traps that will cost you a day

### 1. `responsive_sizer`'s `.sp` is quadratic, not a font unit

Despite the name, `.sp` is **not** scale-independent pixels. The package computes:

```dart
double get sp => this * (((h + w) + (pixelRatio * aspectRatio)) / 2.08) / 100;
```

`h` and `w` are themselves `this`-scaled, so the value appears twice and the
result grows with the square. On a 411x914dp phone:

| Written | Actual |
|---------|--------|
| `10.sp` | ~6px |
| `20.sp` | ~26px |
| `40.sp` | ~102px |
| `70.sp` | ~313px |
| `110.sp` | **~774px** |

Small values are harmless. Anything above roughly `30.sp` explodes. This is why
the codebase once had 500px decorative circles, a 774px blank gap under the
profile page, and currency amounts truncating to "₹1…".

**Rule: never use `.sp` for `Icon(size:)` or for a fixed container height/width.**
Use raw logical pixels there. `.sp` is fine for font sizes and small paddings.
Bottom padding that clears the dashboard dock is raw `90`.

### 2. Never wrap a `LayoutBuilder` in `Obx`

GetX detects dependencies by running the builder synchronously and checking
whether any observable was read. `LayoutBuilder` defers its callback to the
*layout* phase, so `Obx` sees zero reads, throws
`"improper use of a GetX has been detected"`, and the route renders as a blank
white screen in release builds.

Wrap the reactive leaves individually instead:

```dart
// Wrong — blank screen
Obx(() => LayoutBuilder(builder: (_, box) => Text('${c.value}')))

// Right
LayoutBuilder(builder: (_, box) => Obx(() => Text('${c.value}')))
```

The same applies to any builder that defers its callback.

---

## 🚀 Getting started

Setting up on a fresh machine? Follow [SETUP.md](SETUP.md) — there are two cached
packages that need patching or the build fails, and a JDK version that matters.

```bash
flutter pub get
flutter run                 # debug on a connected device
flutter build apk --release
```

### Build environment notes

- **JDK 21** is required for this Gradle setup:
  `flutter config --jdk-dir="C:\Program Files\Android\openjdk\jdk-21.0.8"`
- **minSdk is 23** — `firebase_messaging` requires Android 6.0+.
- **`permission_handler` is pinned to 11.3.1.** Version 12.x ships a Kotlin DSL
  Android module that this Gradle/AGP combination cannot compile.
- **Gradle heap is 2G** (`android/gradle.properties`). On an 8GB machine, do not
  run a build and the Android emulator at the same time — the JVM dies with
  "Gradle build daemon disappeared".
- Two cached pub packages need null-safety patches to compile against the current
  Kotlin compiler. They live in the pub cache, so `pub cache repair` or a fresh
  machine will need them again:
  - `hl_image_picker_android/.../ImageFileCompressEngine.kt` — `os` → `os!!`
  - `smart_auth/.../AppSignatueHelper.kt` — `signingInfo` → `signingInfo!!`,
    `signatures` → `signatures!!`

### API

Base URL is configured in
[`lib/services/api_constant/api_constants.dart`](lib/services/api_constant/api_constants.dart)
(`UATBaseUrlSURF` / `PRODBaseUrlSURF`). Endpoints follow `<base>/andrd/<endpoint>`
on Android and `<base>/ios/<endpoint>` on iOS.

| What | Where |
|------|-------|
| REST API | `https://crm.salaryuncle.com/api/` |
| CIBIL report PDF | `https://salaryuncle.com/viewCustomerCibilPDF/<cibil_id>` |
| Repay / privacy / terms pages | `https://salaryuncle.com/…` |

The CIBIL PDF and the content pages are **not** on the CRM host — check before
assuming one domain serves everything.

## 🔐 Release signing

Release builds use a permanent keystore referenced via `android/key.properties`
(git-ignored). Keep the **same keystore** for every build so the app updates in
place. `android/app/build.gradle` reads it via `signingConfigs.release` and falls
back to the debug key if `key.properties` is missing — so a build on a machine
without the keystore produces an APK that **cannot** update the Play Store
listing. It is fine for side-loaded testing only.

> ⚠️ **Never commit** `key.properties` or the `.jks` keystore — they are listed in
> `android/.gitignore`.

## 📦 App identity

- Application ID: `com.salaryuncle.salaryuncle`
- Android namespace: `com.salarytopup.salarytopup` (pre-rebrand; changing it
  means regenerating `google-services.json`)
- Dart package name: `tejas_loan` (pre-rebrand, used in every import path)
- App name: **SalaryUncle**
- Version: `1.2.0 (3)`

---

© Julania Finance Pvt Ltd — RBI-registered NBFC (Reg. No. B-14.01650).
Website: [salaryuncle.com](https://salaryuncle.com)
