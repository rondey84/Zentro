import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:zentro/data/model/appdata.dart';
import 'package:zentro/generated/objectbox.g.dart';

class ObjectBox {
  late final Store _store;

  late final Box<AppData> appDataBox;

  ObjectBox._create(this._store) {
    appDataBox = _store.box<AppData>();
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "objectBox"));
    return ObjectBox._create(store);
  }

  AppData? getAppData(int id) => appDataBox.get(id);
  int insertAppData(AppData ad) => appDataBox.put(ad);
  bool deleteAppData([int id = 0]) => appDataBox.remove(id);
}
