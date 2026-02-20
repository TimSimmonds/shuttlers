# Sentinel Journal 🛡️

## Security Improvements

### [MEDIUM] Keyboard Caching of Sensitive Input
- **Issue:** Email input field in `passwordDialog` was missing `enableSuggestions: false`.
- **Impact:** OS-level keyboard might cache user emails, potentially exposing them.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Date:** 2023-10-27

### [HIGH] Race Condition in Bank Balance Update
- **Issue:** Deleting a member performed non-atomic read-then-write on the total bank balance.
- **Impact:** Multiple simultaneous deletions could result in an incorrect total bank balance.
- **Fix:** Used `WriteBatch` for atomicity and `FieldValue.increment()` for atomic balance updates in `lib/ui/widgets/member_card_admin.dart`.
- **Date:** 2026-02-20
