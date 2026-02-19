# Sentinel Security Journal

## Security Fixes & Enhancements

### 1. Hardened Email Input Field
- **Severity:** MEDIUM
- **Vulnerability:** Potential OS-level keyboard caching of user credentials.
- **Fix:** Added `enableSuggestions: false` to the email `TextField` in `lib/ui/screens/home_screen.dart`.
- **Impact:** Prevents sensitive email addresses from being cached and suggested by the mobile OS keyboard, reducing the risk of credential exposure.
