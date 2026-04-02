1. **Request Plan Review**
   - Wait for approval on the plan.
2. **Update `_changePasswordDialog` in `lib/ui/screens/home_screen.dart`**
   - Add a `TextFormField` for the `Current Password`.
   - Update the "CHANGE" button to re-authenticate the user using `EmailAuthProvider.credential` and `auth.currentUser!.reauthenticateWithCredential()`.
   - Enforce "Fail Secure": Only close the dialog (`Navigator.pop(context)`) if the password update succeeds or if "CANCEL" is explicitly pressed.
   - Use `if (context.mounted)` checks before using `BuildContext` across asynchronous operations.
3. **Run Pre Commit Steps**
   - Ensure proper testing, verification, review, and reflection are done by calling `pre_commit_instructions`.
4. **Submit PR**
   - Provide a descriptive commit message following the required format.
