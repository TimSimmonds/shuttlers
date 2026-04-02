# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

## 2024-05-24 - Hide hardcoded API Keys
**Learning:** Found that Firebase API keys were hardcoded in `lib/firebase_options.dart`, which is a critical security vulnerability.
**Action:** Used `const String.fromEnvironment('FIREBASE_WEB_API_KEY')` and `const String.fromEnvironment('FIREBASE_ANDROID_API_KEY')` to inject keys at build/run time instead of hardcoding them.
