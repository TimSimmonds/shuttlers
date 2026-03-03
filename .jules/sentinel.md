# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Unauthorized Password Change
- **Issue:** The `_changePasswordDialog` in `lib/ui/screens/home_screen.dart` allowed changing passwords without re-authentication.
- **Impact:** An unauthorized person with temporary access to an unlocked device could change the user's password and take over the account.
- **Fix:** Implemented `reauthenticateWithCredential` in the `Auth` utility and added a "Current Password" field to the change password dialog.
- **Date:** 2024-05-15
