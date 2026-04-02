# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27
## $(date +%Y-%m-%d) - [Password Re-authentication Dialog Vulnerability]
**Learning:** Found that `reauthenticateWithCredential` MUST be called before performing sensitive user actions like `updatePassword` to ensure the session is actively authenticated and valid. Relying on basic session state can lead to insecure flows if the session is stale. Also, we must dispose of `TextEditingController` objects when dismissing a dialog to prevent memory leaks and "Fail Secure" by keeping the dialog open upon a failure to reflect error states instead of silently closing it.
**Action:** Always include a "Current Password" field, generate credentials using `EmailAuthProvider.credential(email: auth.currentUser!.email!, password: currentPassword)`, call `reauthenticateWithCredential(credential)`, wrap all these in a `try/catch` with explicit UI error handling, and forcefully dispose of controllers after awaiting the dialog completion.
