# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Atomic Update Vulnerability in Member Deletion
- **Issue:** Member deletion and the corresponding update to the global bank balance were performed as separate, non-atomic Firestore operations. This created a race condition where one operation could succeed while the other failed, leading to data inconsistency.
- **Impact:** Potential for the global bank balance to become out of sync with individual member balances, compromising the financial integrity of the app.
- **Fix:** Refactored member deletion to use a `WriteBatch` in `Store.deleteMember`, ensuring that both the member document deletion and the `overview` bank balance update (using `FieldValue.increment`) occur atomically.
- **Date:** 2024-05-24
