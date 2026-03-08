# Sentinel's Journal

## Security Fixes

### 🛡️ Sentinel: HIGH Fix Insecure Password Change Flow

- **Vulnerability:** Insecure Password Change Flow. The previous implementation attempted to sign the user out and then back in to update the password, which is unreliable and doesn't follow security best practices. It also lacked a "Current Password" requirement for re-authentication.
- **Fix:** Refactored the authentication logic into a dedicated `Auth` utility class. Implemented `reauthenticateWithCredential` in the `changePassword` method to ensure the user is actively authenticated before the password update. Updated the UI to require the current password and properly handle errors. Added `context.mounted` checks and disposed of `TextEditingController` instances.
- **Impact:** Prevents unauthorized password changes and improves the stability and security of the authentication flow.
- **Learning:** Always use `reauthenticateWithCredential` for sensitive Firebase Authentication operations. Ensure `BuildContext` is still valid using `context.mounted` after asynchronous gaps.
