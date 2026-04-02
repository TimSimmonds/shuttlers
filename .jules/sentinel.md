# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27
## 2024-05-18 - Missing Re-authentication Before Password Update
**Learning:** Found that `updatePassword` in `lib/ui/screens/home_screen.dart` was called directly without first requiring the user to re-authenticate with their current password. Firebase Auth throws `requires-recent-login` if the session is too old, and failing to verify the current password allows an attacker with access to an unlocked device to take over the account.
**Action:** Implemented `reauthenticateWithCredential` using `EmailAuthProvider.credential` before calling `updatePassword`, added a current password field with `obscureText: true`, and ensured the dialog remains open ("Fail Secure") if the update fails.
