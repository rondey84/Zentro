part of '../firebase_service.dart';

class FirebaseStorageHelper {
  late final FirebaseStorage _firebaseStorage;
  late final Reference _firebaseStorageRef;

  FirebaseStorageHelper() {
    _firebaseStorage = FirebaseStorage.instance;
    _firebaseStorageRef = _firebaseStorage.ref();
  }

  Reference? get resImagesRef => _firebaseStorageRef.child('restaurants');

  Future<String?> fetchRestaurantImageDownloadUrl({
    required String resId,
    required String image,
  }) async {
    var imageRef = resImagesRef?.child('$resId/$image');
    var url = await imageRef?.getDownloadURL();
    return url;
  }
}
