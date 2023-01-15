import 'package:objectbox/objectbox.dart';

@Entity()
class AppData {
  int id;

  bool onBoardComplete;

  AppData({
    this.id = 0,
    this.onBoardComplete = false,
  });
}
