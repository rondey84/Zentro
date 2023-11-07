part of '../firebase_service.dart';

class FirebaseAuthHelper {
  late final FirebaseAuth _firebaseAuth;
  UserCredential? userCredential;

  FirebaseAuthHelper() {
    _firebaseAuth = FirebaseAuth.instance;
    // _firebaseAuth.setSettings(appVerificationDisabledForTesting: true);
  }

  Rx<User?> get currentUser => Rx<User?>(_firebaseAuth.currentUser);
  Stream<User?> get userChanges => _firebaseAuth.userChanges();
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  RxString verificationId = ''.obs;

  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    VoidCallback? updateState,
    VoidCallback? errorHandler,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY! Sign the user in (or link) with the auto-generated credential
        userCredential = await _firebaseAuth.signInWithCredential(credential);
        navigateOnVerification();
      },
      codeSent: (String verificationId, int? resendToken) {
        if (updateState != null) updateState();
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (errorHandler != null) errorHandler();
        if (e.code == 'invalid-phone-number') {
          CustomSnackbars.error(
            title: 'Invalid Phone Number',
            message: 'The provided phone number is not valid',
          );
        } else if (e.code == 'too-many-requests') {
          CustomSnackbars.error(
            title: 'Too Many Requests',
            message:
                'Too many attempts has been made from this device, please try again after some time.',
          );
        } else {
          CustomSnackbars.error(
            title: 'Unknown Error',
            message: 'Something went wrong. Try again or contact support.',
          );
        }
        debugPrint('ERROR!!! $e');
      },
    );
  }

  Future<bool> verifyOTP({required String otp}) async {
    try {
      userCredential = await _firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId.value,
          smsCode: otp,
        ),
      );

      return userCredential!.user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        CustomSnackbars.error(
          title: 'Invalid OTP',
          message: 'Check the OTP sent to your mobile number',
        );
      }
      return false;
    } catch (e) {
      CustomSnackbars.error(
        title: 'Unknown Error',
        message: 'Something went wrong. Try again or contact support.',
      );
      return false;
    }
  }

  Future<void> signOut() async {
    userCredential = null;
    verificationId.value = '';
    await _firebaseAuth.signOut();
    Get.offAllNamed(AppRoutes.LOGIN_REGISTER);
  }

  void navigateOnVerification() async {
    if (userCredential != null) {
      await FirebaseService.instance.fireStoreHelper
          .saveUserData(currentUser.value);
      var isNewUser = userCredential!.additionalUserInfo!.isNewUser;
      Get.offAllNamed(isNewUser ? AppRoutes.NEW_USER_REGISTER : AppRoutes.HOME);
    }
  }
}
