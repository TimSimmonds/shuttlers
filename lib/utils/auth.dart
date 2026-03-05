import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  User? get currentUser {
    return auth.currentUser;
  }

  Future<void> signIn({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> changePassword({
    required String password,
    required String newPassword,
  }) async {
    final user = auth.currentUser;
    if (user == null || user.email == null) {
      throw Exception('No user signed in');
    }

    // Re-authenticate user before changing password
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }
}
