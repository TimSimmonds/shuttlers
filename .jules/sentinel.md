# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [CRITICAL] API Key Exposure
- **Issue:** Hardcoded Firebase API keys were present in `lib/firebase_options.dart`.
- **Impact:** Hardcoded keys could lead to unauthorized API usage and potential billing or data exploitation.
- **Fix:** Moved API keys to native environment variables using `String.fromEnvironment`.
- **Date:** 2024-05-24
