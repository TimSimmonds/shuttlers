# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27
## Sentinel Security Log

### Fix: Insecure Password Change (Severity: HIGH)
- **Vulnerability**: The previous password change implementation attempted to sign the user out and then sign them back in with a provided password before updating it. This was logic-heavy and didn't follow the "Fail Secure" principle correctly.
- **Fix**: Implemented `reauthenticateWithCredential` in `Auth.changePassword`. This is the standard and most secure way to re-verify a user's session before sensitive operations in Firebase.
- **UI Enhancement**: Added a "Current Password" field to the Change Password dialog to facilitate re-authentication.
- **Code Health**: Refactored `MenuScreen` to use a dedicated `Auth` utility class, implemented proper `StreamSubscription` management, and ensured `TextEditingController` disposal to prevent memory leaks.
- **Verification**: Verified via `flutter analyze` and `flutter test`. Visual verification confirmed the presence of the new UI field.
