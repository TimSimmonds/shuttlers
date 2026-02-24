# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Change & Missing Re-authentication
- **Issue:** Password change dialog allowed changing passwords without current password verification, and lacked re-authentication.
- **Impact:** Potential for unauthorized password changes if session is hijacked or device left unlocked.
- **Fix:** Implemented `reauthenticateWithCredential` in `Auth` class and updated `_changePasswordDialog` to require current password.
- **Date:** 2023-10-28
