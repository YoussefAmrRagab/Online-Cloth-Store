import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  User? get _currentUser => _auth.currentUser;

  bool get isUserAuthenticated => _currentUser != null;

  String get userId => _currentUser!.uid;

  Future<void> createUser(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _currentUser?.sendEmailVerification();
  }

  Future<void> authUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (!_currentUser!.emailVerified) {
      await _currentUser?.sendEmailVerification();
      throw 'notVerifiedException';
    }
  }

  Future<void> resetPassword(String email) async =>
      await _auth.sendPasswordResetEmail(email: email);
}
