part of '../user_profile.dart';

class UsersFavRestController extends GetxController {
  final _fireStore = FirebaseService.instance.fireStoreHelper;
  final _localStorageService = LocalStorageService.instance;
  String header = 'Favorite Restaurants';
  final hasOrdersDataLoaded = false.obs;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<Restaurant> favRestaurants = [];

  final removeIndex = 0.obs;
  @override
  void onInit() {
    _fetchData();
    super.onInit();
  }

  Future<void> _fetchData() async {
    final favRestIds = await _fireStore.userFavData;

    if (favRestIds == null || favRestIds.isEmpty) {
      hasOrdersDataLoaded.value = true;
      return;
    }

    await Future.forEach(favRestIds, (restId) async {
      final rest = await _fireStore.getRestaurantData(restId);
      if (rest != null) {
        favRestaurants.add(rest);
      }
    });
    hasOrdersDataLoaded.value = true;
  }

  Future<void> removeFavRestaurant(int index) async {
    final restaurantId = favRestaurants[index].restaurantId;
    final userData = _localStorageService.getUserData();

    await FirebaseService.instance.fireStoreHelper
        .removeFavRestaurant(restaurantId);

    userData.favRestaurants.remove(restaurantId);
    _localStorageService.insertUserData(userData);

    removeIndex.value = index;
  }

  void navigateToRestaurant(int index) {
    Get.toNamed(
      AppRoutes.RESTAURANT,
      parameters: {'restaurantId': favRestaurants[index].restaurantId},
    );
  }
}
