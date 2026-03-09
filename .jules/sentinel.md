# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Change
- **Issue:** Users could update their password without recent re-authentication, and the previous implementation attempted a buggy sign-out/sign-in flow.
- **Impact:** Potential account takeover if a session is left open; unreliable password updates.
- **Fix:** Implemented `reauthenticateWithCredential` in `lib/utils/auth.dart` and updated `_changePasswordDialog` in `lib/ui/screens/home_screen.dart` to require the current password. Added `context.mounted` checks and proper `TextEditingController` disposal.
- **Date:** 2026-03-09
