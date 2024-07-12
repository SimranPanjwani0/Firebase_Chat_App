import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> anonymousLogIn() async {
    UserCredential credential = await auth.signInAnonymously();

    return credential.user;
  }

  AuthHelper._();
  static final AuthHelper instance = AuthHelper._();
}
