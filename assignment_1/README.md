# Learn ABC & 123 — Flutter App

A playful learning app to help kids learn the English alphabet (A–Z) and numbers (1–10) with a colorful UI and friendly text‑to‑speech audio.

Submitted by: Debdoot Manna (Roll No: 23CS043)

## Features
- Learn ABC: Tap any letter to hear “A for Apple”, etc., with cute emojis and bright gradient cards.
- Learn 123: Tap numbers 1–10 to hear “1 – One”, “2 – Two”, etc.
- Play All: Auto‑speak through the list for quick practice.
- Kid‑friendly fonts and bouncy tap animations.

## Screenshots

<p>
	<img src="public/images/Simulator Screenshot - iPhone 16 Pro - 2025-08-09 at 22.13.55.png" alt="Home" width="260"/>
	<img src="public/images/Simulator Screenshot - iPhone 16 Pro - 2025-08-09 at 22.14.12.png" alt="ABC Screen" width="260"/>
	<img src="public/images/Simulator Screenshot - iPhone 16 Pro - 2025-08-09 at 22.14.27.png" alt="123 Screen" width="260"/>
  
</p>

## Run locally

```bash
flutter pub get
flutter run
```

If building for iOS after adding plugins:

```bash
flutter clean
flutter pub get
cd ios && pod install
```

## Tech
- Flutter (Material 3)
- google_fonts for kid‑friendly typography
- flutter_tts for text‑to‑speech

