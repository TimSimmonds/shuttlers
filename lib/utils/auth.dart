import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  get currentUser {
    return auth.currentUser;
  }

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<void> signIn({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> changePassword({
    required String password,
    required String newPassword,
  }) async {
    final user = auth.currentUser;
    if (user != null && user.email != null) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      // Re-authenticate the user before changing the password
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } else {
      throw Exception("No user logged in or email missing.");
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
