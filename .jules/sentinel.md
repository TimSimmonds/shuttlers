# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Change Flow
- **Issue:** Password change dialog allowed changing passwords without current password verification, and the  utility used an insecure sign-out/sign-in hack.
- **Impact:** Potential for unauthorized password changes if a device is left unlocked.
- **Fix:** Implemented  in  and updated the UI to require the current password.
- **Date:** 2026-02-25

### [HIGH] Insecure Password Change Flow
- **Issue:** Password change dialog allowed changing passwords without current password verification, and the `Auth` utility used an insecure sign-out/sign-in hack.
- **Impact:** Potential for unauthorized password changes if a device is left unlocked.
- **Fix:** Implemented `reauthenticateWithCredential` in `Auth.changePassword` and updated the UI to require the current password.
- **Date:** 2024-05-23
