# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [CRITICAL] Insecure Password Reset via Unauthenticated API
- **Issue:** The app permitted changing a user's password without prompting for their current password. It previously attempted an insecure hack of signing the user out and signing them back in with a supplied password string, which compromised session integrity and failed to properly re-authenticate the request.
- **Impact:** An unauthorized person who gains access to an unlocked device could arbitrarily change the account password.
- **Fix:** Refactored `Auth.changePassword` (fixing typo) to require a `password` (current password) parameter. Utilized `EmailAuthProvider.credential` with the user's current email and the provided password, followed by `auth.currentUser!.reauthenticateWithCredential(credential)` before securely executing `auth.currentUser!.updatePassword(newPassword)`. Updated `_changePasswordDialog` to include a secure `_currentPasswordController` field and only close on success ("Fail Secure").
- **Date:** 2023-10-27
