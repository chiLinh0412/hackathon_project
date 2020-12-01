import "package:firebase_auth/firebase_auth.dart";

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges();
  }

  Future registerEmail(
      String email, String password, String pseudo, String url) async {
    try {
      UserCredential res = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      res.user.updateProfile(displayName: pseudo, photoURL: url);
      signInEmail(res.user.email, password);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signInEmail(String email, String password) async {
    try {
      UserCredential res = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User fuser = res.user;
      return fuser;
    } catch (e) {
      print(e.message);
      return null;
    }
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
