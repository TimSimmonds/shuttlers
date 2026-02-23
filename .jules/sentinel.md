# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Change (Missing Re-authentication)
- **Issue:** The `_changePasswordDialog` in `home_screen.dart` allowed updating passwords without verifying the user's current password, which is insecure and could fail due to Firebase's "recent login" requirement.
- **Impact:** Potential unauthorized password changes and brittle user experience.
- **Fix:** Enhanced the `Auth` utility to support `reauthenticateWithCredential` and updated the UI to require the current password before updating to a new one.
- **Date:** 2023-11-20
