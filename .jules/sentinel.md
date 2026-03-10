# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Insecure Password Update Flow
- **Issue:** Password update flow was missing re-authentication and the previous implementation used an insecure sign-out/sign-in method. Additionally, `MenuScreen` was using `FirebaseAuth` directly without proper stream cleanup.
- **Impact:** Potential for unauthorized password changes if a device is left unlocked. Risk of memory leaks and unstable state updates.
- **Fix:**
    - Improved `Auth` utility class to use `reauthenticateWithCredential` for secure password updates.
    - Updated `_changePasswordDialog` in `lib/ui/screens/home_screen.dart` to require the current password.
    - Implemented "Fail Secure" principle: Dialog remains open on error to show feedback.
    - Refactored `MenuScreen` to use `Auth` class with proper `StreamSubscription` cancellation and `TextEditingController` disposal.
    - Added `context.mounted` and `mounted` checks for asynchronous stability.
- **Date:** 2023-11-20
