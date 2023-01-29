part of '../home.dart';

class _NearBySection extends GetView<HomeController> {
  const _NearBySection();

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
          child: _SubHeader(text: 'Near You'),
        ).inGridArea('header'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: List.generate(3, (index) => card('Item ${index + 1}')),
            ),
          ),
        ).inGridArea('cards'),
      ],
    );
  }

  Widget card(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 220,
            height: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: controller.fontStyle!.cardHeader,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
