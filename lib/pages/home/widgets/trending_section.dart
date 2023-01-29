part of '../home.dart';

class _TrendingSection extends GetView<HomeController> {
  const _TrendingSection();

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      areas: '''
        header
        cards
      ''',
      columnSizes: [1.fr],
      rowSizes: const [auto, auto],
      rowGap: 8,
      gridFit: GridFit.passthrough,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: _SubHeader(text: 'Trending'),
        ).inGridArea('header'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: List.generate(
                3,
                (index) => card(
                    name: 'Item ${index + 1}',
                    rating: index * 1.0,
                    locality: 'Item $index'),
              ),
            ),
          ),
        ).inGridArea('cards'),
      ],
    );
  }

  Widget card({
    required String name,
    required double rating,
    required String locality,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 270,
            height: 380,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Colors.blueGrey,
            ),
            margin: const EdgeInsets.only(bottom: 4),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(name, style: controller.fontStyle!.cardTitle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_rate_rounded,
                  size: 16,
                  color: controller.fontStyle!.body2.color,
                ),
                const SizedBox(width: 4),
                Text('$rating', style: controller.fontStyle!.body2),
                const SizedBox(width: 16),
                Text(locality, style: controller.fontStyle!.body2)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
