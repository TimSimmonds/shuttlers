# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Non-Atomic Member Deletion and Balance Update
- **Issue:** Deleting a member and updating the total bank balance were performed as separate, non-atomic Firestore operations in `MemberCardAdmin`. This could lead to data inconsistency if one operation failed or if a race condition occurred.
- **Impact:** Inconsistent financial data in the `overview` collection.
- **Fix:** Implemented `deleteMember` in `Store` class using `WriteBatch` and `FieldValue.increment()` to ensure atomic updates. Updated `MemberCardAdmin` to use this new method.
- **Date:** 2025-01-24
