part of '../firebase_service.dart';

class FirebaseAuthHelper {
  FirebaseApp firebaseApp;
  late final FirebaseAuth _firebaseAuth;

  FirebaseAuthHelper(this.firebaseApp) {
    _firebaseAuth = FirebaseAuth.instance;
  }

  Rx<User?> get currentUser => Rx<User?>(_firebaseAuth.currentUser);
  Stream<User?> get userChanges => _firebaseAuth.userChanges();
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
