# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Change Flow
- **Issue:** Password change dialog allowed changing password without verifying current password and was using direct FirebaseAuth calls instead of the Auth utility.
- **Impact:** Potential for unauthorized password changes if a device is left unlocked. Direct FirebaseAuth usage bypassed project abstractions.
- **Fix:** Implemented current password verification using `reauthenticateWithCredential` in `lib/utils/auth.dart` and updated `lib/ui/screens/home_screen.dart` to use this method and the `Auth` utility class.
- **Date:** 2026-02-26
