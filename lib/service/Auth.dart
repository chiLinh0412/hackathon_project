import "package:firebase_auth/firebase_auth.dart";

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges();
  }

  Future registerEmail(
      String email, String password) async {
      UserCredential res = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      signInEmail(res.user.email, password);
  }

  Future signInEmail(String email, String password) async {
      UserCredential res = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User fuser = res.user;
      return fuser;
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
