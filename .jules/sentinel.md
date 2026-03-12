# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27
### [HIGH] Insecure Password Change Implementation
- **Issue:** `_changePasswordDialog` allowed changing the password without verifying the user's current password (`reauthenticateWithCredential`), exposing the account to takeover if a device is left unlocked.
- **Impact:** Unauthorized password change leading to account loss.
- **Fix:** Added a `_currentPasswordController` and called `reauthenticateWithCredential` prior to `updatePassword` in `lib/ui/screens/home_screen.dart`. Implemented "Fail Secure" principle by keeping the dialog open on errors and displaying specific error messages via SnackBar. Also properly disposed `TextEditingController` instances.
- **Date:** 2024-05-18
