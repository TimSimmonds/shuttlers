# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Update
- **Issue:** `_changePasswordDialog` in `home_screen.dart` allowed updating passwords without re-authentication.
- **Impact:** Unauthorized password changes if a device is left unlocked; potential Firebase error for long-running sessions.
- **Fix:** Implemented `reauthenticateWithCredential` in `Auth` utility and added 'Current Password' field to `_changePasswordDialog`.
- **Date:** 2023-10-27
