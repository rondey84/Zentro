enum HeroTag {
  profileHeader,
  cartMainText,
  cartItemCount,
  cartPriceValue,
}

extension HeroTagExtension on HeroTag {
  String get tag {
    return name.replaceAllMapped(
      RegExp('([A-Z])'),
      (match) => '-${match.group(1)!.toLowerCase()}',
    );
  }
}
