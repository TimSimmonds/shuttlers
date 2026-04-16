# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27
## 2024-04-16 - [CRITICAL] Fix API Key Exposure

**Vulnerability:**
Hardcoded Firebase API keys were found in `lib/firebase_options.dart` (`AIzaSyChYPaVkxEK2KCUZwnxrHXe2SJ2B4XL18E` and `AIzaSyDvY2N9LRp3lyDYFa99L4OVGJUWJB0uJGM`).

**Impact:**
Unauthorized usage of Firebase services, potential quota exhaustion, data manipulation, and billing increases if malicious actors use the keys.

**Fix:**
Removed the hardcoded keys and replaced them with `String.fromEnvironment('FIREBASE_WEB_API_KEY')` and `String.fromEnvironment('FIREBASE_ANDROID_API_KEY')`. The app now requires keys to be passed securely via `--dart-define` at build/runtime.
