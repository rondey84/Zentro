import 'package:get/get.dart';
import 'package:zentro/data/model/appdata.dart';
import 'package:zentro/util/object_box.dart';

class LocalStorageService extends GetxService {
  late ObjectBox _box;
  late AppData appData;

  Future<LocalStorageService> init() async {
    _box = await ObjectBox.create();
    storageSetup();
    // TODO: DEBUG CODE, REMOVE BEFORE PRODUCTION
    await Future.delayed(const Duration(seconds: 1));
    return this;
  }

  void storageSetup() {
    if (_box.appDataBox.isEmpty()) {
      appData = AppData();
      _box.insertAppData(appData);
    } else {
      appData = _box.appDataBox.getAll()[0];
    }
  }

  void setOnBoardingStatus() {
    appData.onBoardComplete = true;
    _box.insertAppData(appData);
  }
}
