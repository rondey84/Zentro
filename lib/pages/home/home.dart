import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/constants/hero_tags.dart';
import 'package:zentro/pages/home/home_controller.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

part './widgets/profile_header.dart';
part './widgets/search_bar.dart';
part './widgets/sub_header.dart';
part './widgets/near_by_section.dart';
part './widgets/trending_section.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            const SliverToBoxAdapter(
              child: Hero(
                tag: HeroTag.profileHeader,
                child: _ProfileHeader(),
              ),
            )
          ],
          body: ListView(
            physics: const ScrollPhysics(),
            children: const [
              _SearchBar(),
              SizedBox(height: 16),
              _NearBySection(),
              SizedBox(height: 12),
              _TrendingSection(),
            ],
          ),
        ),
      ),
    );
  }
}
