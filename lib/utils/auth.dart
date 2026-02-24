import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  get currentUser {
    return auth.currentUser;
  }

  Stream<User?> authStateChanges() {
    return auth.authStateChanges();
  }

  Future<void> signIn({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    User? user = auth.currentUser;
    if (user != null && user.email != null) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      // Re-authenticate user before sensitive operation
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } else {
      throw Exception("No user logged in or email missing.");
    }
  }
}
