# 🌌 Aryonika

<div align="center">

**Dating & Compatibility Under the Stars**

A cross-platform dating app powered by astrology, numerology, and cosmic design.

[Flutter](https://flutter.dev) · [Firebase](https://firebase.google.com) · Android · iOS · Web · Desktop

</div>

---

## 🚀 About

**Aryonika** (working title: *LoveQuest*) is a cross-platform dating application focused on
**astrological, numerological, and psychological compatibility**.

The app combines a dark cosmic UI with modern dating mechanics: feed, swipe discovery,
private chats, public channels, and a dedicated **Oracle** section with esoteric content.

> ⚠️ **Important**  
> Backend services (API, Firebase Cloud Functions, AI logic) are **not included** in this repository  
> and are deployed separately.

---

## ✨ Features

| Area | Description |
|-----|------------|
| **Feed** | Posts and interest-based public channels |
| **Discovery** | Swipe cards with filters (age, gender, country, zodiac) |
| **Chats** | Private encrypted messaging |
| **Channels** | Public channels, posts, comments, reactions |
| **Oracle** | Horoscopes, tarot, numerology, palmistry, cosmic forecasts |
| **Compatibility** | Natal charts, numerology, Chinese & Vedic astrology |
| **Profile** | Cosmic passport, PRO subscription, notifications |

🌍 **9 languages supported** (EN, RU, DE, ES, FR, and others)

---

## 🧰 Tech Stack

- **Flutter** 3.x (Dart 3)
- **Firebase**
  - Authentication
  - Firestore
  - Storage
  - Crashlytics
- **State management**: `flutter_bloc` (Cubit)
- **Navigation**: `go_router`
- **Localization**: ARB + `flutter_localizations`
- **Push notifications**: OneSignal
- **Platforms**: Android, iOS, Web, Windows, macOS, Linux

---

## 📋 Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.0.0
- Firebase account & project
- (Optional) [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/)

---

## ⚙️ Installation & Run

### 1. Clone the repository

```bash
git clone https://github.com/pslergy/Aryonika.git
cd Aryonika
flutter pub get
