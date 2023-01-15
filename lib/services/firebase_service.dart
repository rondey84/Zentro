import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zentro/generated/firebase_options.dart';
import 'package:zentro/routes/app_pages.dart';

part './firebase_helpers/firebase_auth.dart';
part './firebase_helpers/firebase_firestore.dart';

class FirebaseService extends GetxService {
  // ignore: unused_field
  late final FirebaseApp _firebaseApp;
  late final FirebaseAuthHelper firebaseAuthHelper;
  late final FirebaseFireStoreHelper fireStoreHelper;

  Future<FirebaseService> init() async {
    _firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseAuthHelper = FirebaseAuthHelper(_firebaseApp);
    fireStoreHelper = FirebaseFireStoreHelper(_firebaseApp);
    // TODO: DEBUG CODE, REMOVE BEFORE PRODUCTION
    await Future.delayed(const Duration(seconds: 1));
    return this;
  }
}
