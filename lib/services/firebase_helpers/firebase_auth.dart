part of '../firebase_service.dart';

class FirebaseAuthHelper {
  FirebaseApp firebaseApp;
  late final FirebaseAuth _firebaseAuth;
  UserCredential? userCredential;

  FirebaseAuthHelper(this.firebaseApp) {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.setSettings(appVerificationDisabledForTesting: true);
  }

  Rx<User?> get currentUser => Rx<User?>(_firebaseAuth.currentUser);
  Stream<User?> get userChanges => _firebaseAuth.userChanges();
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  RxString verificationId = ''.obs;

  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    VoidCallback? updateState,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY! Sign the user in (or link) with the auto-generated credential
        userCredential = await _firebaseAuth.signInWithCredential(credential);
      },
      codeSent: (String verificationId, int? resendToken) {
        if (updateState != null) updateState();
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again.');
        }
        debugPrint('ERROR!!! $e');
      },
    );
  }

  Future<bool> verifyOTP({required String otp}) async {
    userCredential = await _firebaseAuth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      ),
    );

    return userCredential!.user != null ? true : false;
  }

  Future<void> signOut() async {
    userCredential = null;
    await _firebaseAuth.signOut();
    Get.offAllNamed(AppRoutes.LOGIN_REGISTER);
  }
}
