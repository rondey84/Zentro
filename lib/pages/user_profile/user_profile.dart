import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/hero_tags.dart';
import 'package:zentro/data/enums/order_enums.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/data/model/restaurant_ratings.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
import 'package:zentro/data/model/user_models.dart';
import 'package:zentro/data/model/zentro_order.dart';
import 'package:zentro/pages/user_profile/user_profile_controller.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/extended_colors_style.dart';
import 'package:zentro/util/custom_painters/dashed_line_painter.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/container_card.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/fav_button.dart';
import 'package:zentro/widgets/loading_item.dart';

part './pages/users_orders.dart';
part './pages/users_orders_controller.dart';
part './pages/user_order_detail.dart';
part './pages/users_fav_restaurants.dart';
part './pages/users_fav_restaurant_controller.dart';
part './widgets/profile_header.dart';
part './widgets/list_items.dart';
part './widgets/user_profile_cards.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: HeroTag.profileHeader.tag,
                child: const _ProfileHeader(),
              ),
              const SizedBox(height: 8),
              const _UsersProfileCards(),
              const _ListItems(),
            ],
          ),
        ),
      ),
    );
  }
}
