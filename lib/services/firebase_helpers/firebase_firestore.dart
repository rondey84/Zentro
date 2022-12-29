part of '../firebase_service.dart';

class FirebaseFireStoreHelper {
  FirebaseApp firebaseApp;
  late final FirebaseFirestore _firebaseFireStore;

  FirebaseFireStoreHelper(this.firebaseApp) {
    _firebaseFireStore = FirebaseFirestore.instance;
  }
}
