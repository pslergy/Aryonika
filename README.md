
# 🌌 Aryonika

<div align="center">

**Dating & Compatibility Under the Stars**

A cross-platform dating app powered by astrology, numerology, and cosmic design.

[Flutter](https://flutter.dev) · [Firebase](https://firebase.google.com) · [Android](https://www.android.com) · [iOS](https://www.apple.com/ios)

</div>

---

## 🚀 About the Project

**Aryonika** (aka *LoveQuest*) is a cross-platform dating application focused on astrological and numerological compatibility.

The app features a dark cosmic UI, user feed, swipe-style discovery, chats, public channels, and a dedicated **Oracle** section with horoscopes, tarot, palmistry, and cosmic forecasts.

> ⚠️ Backend (API, Firebase Cloud Functions) is **not included** in this repository and is deployed separately.

---

## ✨ Features

| Section | Description |
|------|------------|
| **Feed** | Posts and interest-based channels |
| **Discovery** | User cards, filters (gender, age, country, zodiac sign) |
| **Chats** | Private encrypted messaging |
| **Channels** | Public channels, posts, comments, reactions |
| **Oracle** | Horoscope, tarot, numerology, palmistry, cosmic events |
| **Compatibility** | Natal charts, numerology, Chinese & Vedic astrology |
| **Profile** | Cosmic passport, PRO subscription, notifications |

🌍 **9 languages supported** (including EN, RU, DE, ES, FR)

---

## 🧰 Tech Stack

- **Flutter** 3.x (Dart 3)
- **Firebase**: Authentication, Firestore, Storage
- **State management**: `flutter_bloc` (Cubit)
- **Navigation**: `go_router`
- **Localization**: ARB + `flutter_localizations`
- **Push notifications**: OneSignal
- **Crash reports**: Firebase Crashlytics
- **Platforms**: Android, iOS, Web, Windows, macOS, Linux

---

## 📋 Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>= 3.0.0)
- Firebase account & project
- (Optional) [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/)

---

## ⚙️ Installation & Run

### 1. Clone & install dependencies

```bash
git clone https://github.com/YOUR_ORG/aryonika.git
cd aryonika
flutter pub get
```

### 2. Firebase config

Generate `lib/firebase_options.dart` and link the app to your Firebase project:

```bash
flutterfire configure
```

Do **not** commit `firebase_options.dart` or `android/app/google-services.json` — they are in `.gitignore`.

### 3. 🔐 Secrets (never commit keys)

**No API keys or secrets must be stored in the code.** All of the following are ignored by git; pass values via `--dart-define` when building.

| Secret | Usage |
|--------|--------|
| `ONESIGNAL_APP_ID` | OneSignal app id (push, init in app). |
| `ONESIGNAL_REST_API_KEY` | OneSignal REST API key (sending notifications from app). |
| Firebase / Google keys | Only in `firebase_options.dart` and `google-services.json` — generate via `flutterfire configure` and **do not commit**. |
| AI / Chat API key (e.g. Google) | Use **only on the backend** (api.psylergy.com). Never put in the Flutter app. |

Example run with OneSignal:

```bash
flutter run --dart-define=ONESIGNAL_APP_ID=your_app_id --dart-define=ONESIGNAL_REST_API_KEY=your_rest_api_key
```

Example release build:

```bash
flutter build apk --dart-define=ONESIGNAL_APP_ID=... --dart-define=ONESIGNAL_REST_API_KEY=...
```

See `env.example` for a checklist.

#### If GitHub Secret Scanning already found leaks

1. **Rotate all exposed keys** in [Firebase Console](https://console.firebase.google.com) and [OneSignal](https://dashboard.onesignal.com) — consider the old keys compromised.
2. **Stop tracking `google-services.json`** (file stays on disk for local builds, but is no longer committed):
   ```bash
   git rm --cached android/app/google-services.json
   git commit -m "Stop tracking google-services.json (secrets)"
   ```
3. Get a fresh `google-services.json` from Firebase Console → Project settings → Your apps, and place it in `android/app/`. Do **not** commit it (it’s in `.gitignore`). Use `android/app/google-services.json.example` as a structure reference.
4. **`notification_service.dart`** no longer contains keys; it reads from `--dart-define`. If the alert points at an old commit, the current code is safe; rotating the OneSignal key is enough.
5. (Optional) To remove secrets from **entire git history**: use [BFG Repo-Cleaner](https://rsc.io/bfg) or `git filter-repo`, then force-push. Prefer rotating keys and stopping tracking of sensitive files first.

### 4. Run

```bash
flutter run
# with OneSignal:
flutter run --dart-define=ONESIGNAL_APP_ID=... --dart-define=ONESIGNAL_REST_API_KEY=...
```
