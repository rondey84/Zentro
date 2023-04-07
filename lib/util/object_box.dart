import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:zentro/data/model/appdata.dart';
import 'package:zentro/data/model/menu.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
import 'package:zentro/generated/objectbox.g.dart';

/// A class representing the ObjectBox database instance and its boxes for the app.
class ObjectBox {
  final Store _store; // ObjectBox's store variable
  static Store? _existingStore;

  // Declaring ObjectBox's boxes
  late final Box<AppData> appDataBox;
  late final Box<user_model.User> userDataBox;
  late final Box<Restaurant> restaurantDataBox;
  late final Box<Menu> menuDataBox;
  late final Box<MenuItem> menuItemDataBox;

  /// Private constructor to create an instance of the ObjectBox class with all boxes.
  ObjectBox._create(this._store) {
    appDataBox = _store.box<AppData>();
    userDataBox = _store.box<user_model.User>();
    restaurantDataBox = _store.box<Restaurant>();
    menuDataBox = _store.box<Menu>();
    menuItemDataBox = _store.box<MenuItem>();
  }

  /// Factory method to create and return a new instance of the ObjectBox class.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docsDir.path, 'objectBox');

    if (_existingStore != null) {
      if (!_existingStore!.isClosed()) {
        return ObjectBox._create(_existingStore!);
      }
    }
    final store = await openStore(directory: dbPath);
    _existingStore = store;
    return ObjectBox._create(store);
  }

  /// Get an instance of [AppData] from the [appDataBox] based on its ID.
  AppData? getAppData(int id) => appDataBox.get(id);

  /// Insert an instance of [AppData] into the [appDataBox] and return its ID.
  int insertAppData(AppData ad) => appDataBox.put(ad);

  /// Delete an instance of [AppData] from the [appDataBox] based on its ID. If no ID is specified, all items will be deleted.
  bool deleteAppData([int id = 0]) => appDataBox.remove(id);

  /// Get an instance of [user_model.User] from the [userDataBox] based on the user's phone number.
  user_model.User? getUserDataOrNull(String phone) {
    var user =
        userDataBox.query(User_.phoneNumber.equals(phone)).build().find();
    if (user.isNotEmpty) return user.first;
    return null;
  }

  /// Get the first instance of [user_model.User] from the [userDataBox].
  user_model.User getUserData() => userDataBox.getAll().first;

  /// Insert an instance of [user_model.User] into the [userDataBox] and return its ID.
  int insertUserData(user_model.User user) {
    return userDataBox.put(user);
  }

  /// Delete all instances of [user_model.User] from the [userDataBox].
  void deleteUserData() => userDataBox.removeAll();

  /// Get an instance of [Restaurant] from the [restaurantDataBox] based on its ID.
  Restaurant? getRestaurantData(String restaurantId) {
    var restaurants = restaurantDataBox
        .query(Restaurant_.restaurantId.equals(restaurantId))
        .build()
        .find();
    if (restaurants.isNotEmpty) return restaurants.first;

    return null;
  }

  /// Insert an instance of [Restaurant] into the [restaurantDataBox] and return its ID.
  int insertRestaurantData(Restaurant res) {
    return restaurantDataBox.put(res);
  }

  /// Get an instance of [Menu] from the [menuDataBox] based on the restaurant ID
  Menu? getMenuData(String restaurantId) {
    var menus =
        menuDataBox.query(Menu_.restId.equals(restaurantId)).build().find();
    if (menus.isNotEmpty) return menus.first;

    return null;
  }

  /// Method for inserting menu data
  int insertMenuData(String restaurantId, Menu menu) {
    menu.restaurant.target = getRestaurantData(restaurantId);
    return menuDataBox.put(menu);
  }

  /// Method for removing menu data
  void removeMenuData(Menu menu) {
    menuDataBox.remove(menu.obId);
  }

  /// Getter for getting menu item data by restaurant ID and menu item ID
  MenuItem? getMenuItemData(String restaurantId, String menuItemId) {
    var menu = getMenuData(restaurantId);
    return menu?.menuItems.firstWhereOrNull((e) => e.id == menuItemId);
  }

  int? insertMenuItemData(String restaurantId, MenuItem menuItem) {
    // Get the parent object
    var menu = getMenuData(restaurantId);
    if (menu == null) return null;

    // Add the child to the parent's relation list
    menu.menuItems.add(menuItem);

    // Persist the changes to the database
    insertMenuData(restaurantId, menu);
    return menuItemDataBox.put(menuItem);
  }

  List<int>? insertMenuItemsData(
      String restaurantId, List<MenuItem> menuItems) {
    var menu = getMenuData(restaurantId);
    if (menu == null) return null;

    menu.menuItems.addAll(menuItems);
    insertMenuData(restaurantId, menu);
    return menuItemDataBox.putMany(menuItems);
  }

  void deleteMenuItemData(String restaurantId, MenuItem menuItem) {
    // Get the parent object
    var menu = getMenuData(restaurantId);
    if (menu == null) return;

    // Remove the child from the parent's relation list
    menu.menuItems.remove(menuItem);

    // Persist the changes to the database
    menuItemDataBox.remove(getMenuItemData(restaurantId, menuItem.id)!.obId);
    insertMenuData(restaurantId, menu);
  }

  void deleteMenuItemsData(String restaurantId) {
    // Get the parent object
    var menu = getMenuData(restaurantId);
    if (menu == null) return;

    menu.menuItems.clear();
    menuItemDataBox.removeAll();
    insertMenuData(restaurantId, menu);
  }
}
