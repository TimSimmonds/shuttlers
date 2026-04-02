# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27
## 2024-04-02 - Secure Password Updates
**Learning:** Firebase Auth password updates without `reauthenticateWithCredential` are insecure, as they do not verify the current session owner's credentials. Also, dialogs must employ a "Fail Secure" approach to prevent masking errors.
**Action:** When creating password change flows, always prompt for the current password, use `EmailAuthProvider.credential`, and execute `user.reauthenticateWithCredential()` before `user.updatePassword()`. Additionally, apply `obscureText`, `autocorrect: false`, and `enableSuggestions: false` to all password fields, and properly dispose of `TextEditingController` objects when dismissing dialogs.
