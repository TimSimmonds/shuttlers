# Shuttlers

A kitty app for my badminton group.

## Features

- Members can see their balance and spending history
- Admin can:
    - add/remove members
    - add expenditure
    - add funds to members

## Breakdown

- Uses Google Firebase as a backend.
    - Admin member is authed through Firebase Authentication.
    - All data is stored on a Firebase Firestore DB with rules only allowin Admin member to add/update/remove data. Anyone can read data.
- Deployed as an Android app and also on GitHub pages. [Click here to check it out!](https://beardytim.github.io/shuttlers/)

## To Do

- [ ] increase admin capability - edit previous games etc.
- [ ] input cost through numberpad

## Building and Running

To build or run the app securely, you need to provide the Firebase API keys via the `--dart-define` flag.

For example:
```bash
flutter run \
  --dart-define=FIREBASE_WEB_API_KEY=your_web_api_key \
  --dart-define=FIREBASE_ANDROID_API_KEY=your_android_api_key
```

When building for a specific platform, include the relevant flags:
```bash
flutter build apk --release \
  --dart-define=FIREBASE_WEB_API_KEY=your_web_api_key \
  --dart-define=FIREBASE_ANDROID_API_KEY=your_android_api_key
```
