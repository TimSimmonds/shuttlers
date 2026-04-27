# Sentinel Journal 🛡️

## Security Improvements

### [CRITICAL] API Key Exposure in Source Code
- **Issue:** Hardcoded Firebase API keys (Web and Android) in `lib/firebase_options.dart`.
- **Impact:** Attackers could scrape the keys and impersonate the app or incur unauthorized backend billing/usage.
- **Fix:** Moved API keys to native environment variables using `String.fromEnvironment`, and documented the `--dart-define` usage in the README.
- **Date:** 2024-04-23

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27
