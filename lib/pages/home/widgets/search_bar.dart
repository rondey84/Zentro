part of '../home.dart';

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 360),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: const TextField(
        decoration: InputDecoration(
          enabled: false,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search_rounded),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
