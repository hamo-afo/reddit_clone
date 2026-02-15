# Secrets & local setup

These files are **not** in the repo because they contain API keys and secrets. You need to add them locally to run the app.

## 1. Firebase Android config: `google-services.json`

- Open [Firebase Console](https://console.firebase.google.com) → your project → Project settings.
- Under "Your apps", select the Android app (or add one with package name `com.example.reddit_tutorial`).
- Download **google-services.json**.
- Put it at: **`android/app/google-services.json`**  
  (same folder as `google-services.json.example`).

## 2. FlutterFire options: `lib/firebase_options.dart`

From the project root, run:

```bash
dart run flutterfire configure
```

This creates/updates `lib/firebase_options.dart` with your Firebase config. Use the same Firebase project as above.

---

**Important:** If these files were ever committed in the past, consider **rotating your keys** in Firebase Console (regenerate API keys / OAuth clients) so old copies in git history cannot be misused.
