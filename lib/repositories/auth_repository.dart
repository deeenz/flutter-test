import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();

  Future<User> login(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (auth.currentUser != null) {
        user = auth.currentUser;
      }
    } catch (e) {
      print(e);
      user = null;
    }

    return user;
  }

  Future<String> register(String email, String password, String name) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'success';
    } catch (e) {
      return e.message;
    }
  }
}
