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
    String email = auth.currentUser!.email.toString();
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await auth.currentUser!.reauthenticateWithCredential(credential);
    await auth.currentUser!.updatePassword(newPassword);
  }
}
