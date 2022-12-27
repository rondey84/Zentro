import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zentro/generated/firebase_options.dart';

class FirebaseService extends GetxService {
  // ignore: unused_field
  late final FirebaseApp _firebaseApp;
  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firebaseFireStore;

  Future<FirebaseService> init() async {
    // TODO: DEBUG CODE, REMOVE BEFORE PRODUCTION
    _firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseFireStore = FirebaseFirestore.instance;

    await Future.delayed(const Duration(seconds: 1));
    return this;
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
