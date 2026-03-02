# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Missing Re-authentication for Password Change
- **Issue:** The application allowed users to update their password without providing their current password.
- **Impact:** If a session is left open or a device is compromised while the app is active, an unauthorized user could change the account password without further verification.
- **Fix:** Implemented `reauthenticateWithCredential` in `Auth` utility and updated `_changePasswordDialog` to require the current password before proceeding with the update.
- **Date:** 2023-10-28
