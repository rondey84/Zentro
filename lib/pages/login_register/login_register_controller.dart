import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zentro/services/firebase_service.dart';

class LoginRegisterController extends GetxController {
  var firebaseService = Get.find<FirebaseService>();
  RxString errorMessage = ''.obs;
  RxBool isLogin = true.obs;

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await firebaseService.firebaseAuthHelper.signInWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? '';
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await firebaseService.firebaseAuthHelper.createUserWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? '';
    }
  }

  void handleSubmit() {
    isLogin.value
        ? signInWithEmailAndPassword()
        : createUserWithEmailAndPassword();
  }

  void toggleLoginState() {
    isLogin.value = !isLogin.value;
  }
}
