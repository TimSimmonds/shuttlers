# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Update Flow
- **Issue:** Password update flow relied on a manual sign-out/sign-in loop and lacked a "Current Password" verification step.
- **Impact:** Potential for session fixation issues or unauthorized password changes if a device was left unlocked.
- **Fix:** Implemented `reauthenticateWithCredential` in `lib/utils/auth.dart` and added a "Current Password" field to `_changePasswordDialog` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2024-05-23
