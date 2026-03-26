# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

## YYYY-MM-DD - API Key Exposure
**Learning:** Hardcoded Firebase API keys in source code files like `lib/firebase_options.dart` can be easily exposed in version control or decompiled apps.
**Action:** Externalize API keys using `String.fromEnvironment('FIREBASE_WEB_API_KEY')` and require them to be provided during the build process via `--dart-define` to keep secrets out of the codebase.
