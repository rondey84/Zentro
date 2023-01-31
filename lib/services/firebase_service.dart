import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/generated/firebase_options.dart';
import 'package:zentro/routes/app_pages.dart';

part './firebase_helpers/firebase_auth.dart';
part './firebase_helpers/firebase_firestore.dart';
part './firebase_helpers/firebase_storage.dart';

class FirebaseService extends GetxService {
  // Firebase App
  late final FirebaseApp _firebaseApp;

  /// Firebase Authentication
  late final FirebaseAuthHelper firebaseAuthHelper;

  /// Firestore Database
  late final FirebaseFireStoreHelper fireStoreHelper;

  /// Firebase Storage
  late final FirebaseStorageHelper firebaseStorageHelper;

  Future<FirebaseService> init() async {
    _firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseAuthHelper = FirebaseAuthHelper(_firebaseApp);
    firebaseStorageHelper = FirebaseStorageHelper();
    fireStoreHelper = await FirebaseFireStoreHelper.init();
    return this;
  }
}
