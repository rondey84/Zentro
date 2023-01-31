import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
        child: CustomScrollView(
          slivers: [
            // SliverToBoxAdapter(
            //   child: ElevatedButton(
            //     onPressed: controller.testHandler,
            //     child: const Text('Test'),
            //   ),
            // ),
            const SliverToBoxAdapter(
              child: Hero(
                tag: HeroTag.profileHeader,
                child: _ProfileHeader(),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchBarDelegate(
                minHeight: 60,
                maxHeight: 60,
                child: const _SearchBar(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                const _NearBySection(),
                const SizedBox(height: 12),
                const _TrendingSection(),
                const SizedBox(height: 24),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
