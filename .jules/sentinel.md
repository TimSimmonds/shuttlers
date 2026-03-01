# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Atomic Member Deletion and Balance Synchronization
- **Issue:** Member deletion and global bank balance update were performed in separate, non-atomic Firestore operations.
- **Impact:** If one operation failed, the bank balance would become inconsistent with the sum of member balances.
- **Fix:** Implemented `deleteMember` in `lib/utils/store.dart` using `WriteBatch` to ensure atomicity, and refactored `MemberCardAdmin` to use this method.
- **Date:** 2023-10-27
