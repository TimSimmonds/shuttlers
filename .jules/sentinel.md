# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Update
- **Issue:** Password update functionality lacked re-authentication, potentially leading to security failures or unauthorized changes in active sessions.
- **Impact:** Compromised accounts if a session remains active on a shared device, and common "requires-recent-login" errors in production.
- **Fix:** Implemented  in  and added a 'Current Password' field to the change password dialog in .
- **Date:** 2026-03-04

### [HIGH] Insecure Password Update
- **Issue:** Password update functionality lacked re-authentication, potentially leading to security failures or unauthorized changes in active sessions.
- **Impact:** Compromised accounts if a session remains active on a shared device, and common 'requires-recent-login' errors in production.
- **Fix:** Implemented 'reauthenticateWithCredential' in 'lib/utils/auth.dart' and added a 'Current Password' field to the change password dialog in 'lib/ui/screens/home_screen.dart'.
- **Date:** 2026-03-04
