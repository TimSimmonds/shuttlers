import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  get currentUser {
    return auth.currentUser;
  }

  Future<void> signIn({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> changePassword({
    required String password,
    required String newPassword,
  }) async {
    final user = auth.currentUser;
    if (user == null || user.email == null) {
      throw Exception('No user is currently signed in.');
    }

    // Create a credential for re-authentication
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    // Re-authenticate the user before updating the password
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }
}
