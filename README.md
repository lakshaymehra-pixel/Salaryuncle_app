# SalaryUncle — Instant Salary Loan App

A modern Flutter loan application with a deep‑green + gold fintech UI. Users can
apply for short‑term salary advances, track active loans, repay, and manage their
profile — all backed by a live loan‑origination API.

> **Tagline:** *Salary khatam? Tension nahi! Instant loan, seedha bank account mein.*

---

## ✨ Features

- **Phone + OTP login** with automatic OTP read (SMS User Consent API).
- **Deep‑green & gold dashboard** — active‑loan hero card, total repayment,
  eligibility strip, quick actions, and tips.
- **Loan application flow** — PAN / Aadhaar KYC, personal, employment, income,
  residence and bank details, document upload.
- **Loan calculator** — pick amount & tenure, live Key‑Fact‑Statement (KFS)
  breakdown (processing fee, GST, interest, total repayment).
- **My Loans / Payments / Profile** tabs with a floating glass bottom dock and a
  gold “New Loan” FAB.
- **Repayment** via the payment gateway.
- Firebase push notifications, AppsFlyer / Meta events, in‑app review.

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
- **pinput + smart_auth** — OTP entry & auto‑read
- **responsive_sizer** — adaptive sizing

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

## 🚀 Getting started

```bash
flutter pub get
flutter run                 # debug on a connected device
flutter build apk --release # signed release APK
```

The release APK is signed with a permanent keystore (see below), so installs
**update in place** without an uninstall.

### API

Base URL is configured in
[`lib/services/api_constant/api_constants.dart`](lib/services/api_constant/api_constants.dart)
(`UATBaseUrlSURF` / `PRODBaseUrlSURF`). Endpoints follow `<base>/andrd/<endpoint>`.

## 🔐 Release signing

Release builds use a permanent keystore referenced via `android/key.properties`
(git‑ignored). Keep the **same keystore** for every build so the app updates in
place. `android/app/build.gradle` reads it via `signingConfigs.release` and falls
back to the debug key if `key.properties` is missing.

> ⚠️ **Never commit** `key.properties` or the `.jks` keystore — they are listed in
> `android/.gitignore`.

## 📦 App identity

- Application ID: `com.salaryuncle.salaryuncle` (installs side‑by‑side with other apps)
- App name: **SalaryUncle**
- Version: `1.2.0 (3)`

---

© Julania Finance Pvt Ltd — RBI‑registered NBFC (Reg. No. B‑14.01650). Website: [salaryuncle.com](https://salaryuncle.com)
